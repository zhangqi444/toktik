var AWS = require("aws-sdk");
var { https } = require("follow-redirects");
var fs = require("fs");
var path = require("path");
const { default: transcribe } = require("./utils/transcribe");

const s3Client = new AWS.S3({
  region: "us-west-2",
});

const transcribeClient = new AWS.TranscribeService();

var download = function (url, dest, cb) {
  var file = fs.createWriteStream(dest);
  var request = https
    .get(url, function (response) {
      response.pipe(file);
      file.on("finish", function () {
        file.close(cb); // close() is async, call cb after close completes.
      });
    })
    .on("error", function (err) {
      // Handle errors
      fs.unlink(dest); // Delete the file async. (But we don't check the result)
      if (cb) cb(err.message);
    });
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

  let fileExt = path.extname(event.audioUrl);
  let s3Key = String(new Date().getTime()) + fileExt;
  let locallySavedAudioFileName = `/tmp/${s3Key}`;

  await new Promise((resolve, reject) => {
    download(event.audioUrl, locallySavedAudioFileName, (error) => {
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

  console.log("hmm", transcribeData);

  return {
    statusCode: 200,
    //  Uncomment below to enable CORS requests
    //  headers: {
    //      "Access-Control-Allow-Origin": "*",
    //      "Access-Control-Allow-Headers": "*"
    //  },
    transcript: JSON.stringify("Hello from Lambda!"),
  };
};
