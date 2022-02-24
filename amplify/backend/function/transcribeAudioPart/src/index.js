var AWS = require("aws-sdk");
const { exec } = require("child_process");
var fs = require("fs");
var path = require("path");
const { default: transcribe } = require("./utils/transcribe");

const s3Client = new AWS.S3({
  region: "us-west-2",
});

var download = function (url, dest, cb) {
  exec(
    `/opt/bin/ffmpeg -ss 300 -i \"${url}\" -t 180 ${dest} -loglevel error`,
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
      input: { audioUrl },
    },
  } = event;

  console.log("audioUrl", audioUrl);
  let fileExt = path.extname(audioUrl);
  let s3Key = String(new Date().getTime()) + fileExt;
  let locallySavedAudioFileName = `/tmp/${s3Key}`;

  await new Promise((resolve, reject) => {
    download(audioUrl, locallySavedAudioFileName, (error) => {
      if (error) {
        reject(error);
        return;
      }
      resolve();
    });
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
    statusCode: 200,
    //  Uncomment below to enable CORS requests
    //  headers: {
    //      "Access-Control-Allow-Origin": "*",
    //      "Access-Control-Allow-Headers": "*"
    //  },
    error: "Hmm",
  };
};
