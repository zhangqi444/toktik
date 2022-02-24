var AWS = require("aws-sdk");
const { exec } = require("child_process");
var fs = require("fs");
var path = require("path");
const { default: transcribe } = require("./utils/transcribe");

const s3Client = new AWS.S3({
  region: "us-west-2",
});

var getFileExtensionFromUrl = (url) => {
  const unformatedExt = path.extname(url);
  const queryPartIndex = unformatedExt.indexOf("?");
  if (queryPartIndex > -1) {
    return unformatedExt.substring(1, queryPartIndex);
  }
  return unformatedExt.substring(1);
};

var download = function (url, startTime, length, dest, cb) {
  exec(
    `/opt/bin/ffmpeg -ss ${startTime} -i \"${url}\" -t ${length} ${dest} -loglevel error`,
    (err, stdout, stderr) => {
      if (err) {
        cb(err);
        return;
      }
      if (stderr) {
        cb(stderr);
        return;
      }
      cb();
    }
  );
  // var file = fs.createWriteStream(dest);
  // var request = https
  //   .get(url, function (response) {
  //     response.pipe(file);
  //     file.on("finish", function () {
  //       file.close(cb); // close() is async, call cb after close completes.
  //     });
  //   })
  //   .on("error", function (err) {
  //     // Handle errors
  //     fs.unlink(dest); // Delete the file async. (But we don't check the result)
  //     if (cb) cb(err.message);
  //   });
};

const uploadFile = (fileName, key, cb) => {
  // Read content from the file
  const fileContent = fs.readFileSync(fileName);

  // Setting up S3 upload parameters
  const params = {
    Bucket: "toktik-transcription-testing",
    Key: key, // File name you want to save as in S3
    Body: fileContent,
  };

  // Uploading files to the bucket
  s3Client.upload(params, cb);
};

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);
  const {
    arguments: {
      input: { audioUrl, startTime, length },
    },
  } = event;

  let fileExt = getFileExtensionFromUrl(audioUrl);
  let s3Key = String(new Date().getTime()) + "." + fileExt;
  let locallySavedAudioFileName = `/tmp/${s3Key}`;

  try {
    await new Promise((resolve, reject) => {
      download(
        audioUrl,
        startTime,
        length,
        locallySavedAudioFileName,
        (error) => {
          if (error) {
            reject(error);
            return;
          }
          resolve();
        }
      );
    });
    console.log("file downloaded");

    const s3Data = await new Promise((resolve, reject) => {
      uploadFile(locallySavedAudioFileName, s3Key, (error, data) => {
        if (error) {
          reject(error);
          return;
        }
        resolve(data);
      });
    });

    const jobName = `${s3Key}_transcription`;

    const transcribeData = await new Promise((resolve, reject) => {
      transcribe(s3Data.Location, jobName, (error, data) => {
        if (error) {
          reject(error);
          return;
        }
        resolve(data);
      });
    });

    const subtitleFileUri =
      transcribeData.TranscriptionJob.Subtitles.SubtitleFileUris[0];
    if (subtitleFileUri) {
      return {
        statusCode: 200,
        //  Uncomment below to enable CORS requests
        //  headers: {
        //      "Access-Control-Allow-Origin": "*",
        //      "Access-Control-Allow-Headers": "*"
        //  },
        subtitleFileUri,
      };
    }

    return {
      statusCode: 500,
      //  Uncomment below to enable CORS requests
      //  headers: {
      //      "Access-Control-Allow-Origin": "*",
      //      "Access-Control-Allow-Headers": "*"
      //  },
      error: "Error while transcribing data",
    };
  } catch (e) {
    console.log("exception", e);

    return {
      statusCode: 500,
      //  Uncomment below to enable CORS requests
      //  headers: {
      //      "Access-Control-Allow-Origin": "*",
      //      "Access-Control-Allow-Headers": "*"
      //  },
      error: "Error while transcribing data",
    };
  }
};
