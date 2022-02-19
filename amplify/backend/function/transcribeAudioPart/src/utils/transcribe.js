var AWS = require("aws-sdk");

const transcribeClient = new AWS.TranscribeService();

const pollTranscription = (jobName, cb) => {
  transcribeClient.getTranscriptionJob(
    {
      TranscriptionJobName: jobName,
    },
    (error, data) => {
      if (error) {
        cb(error);
        return;
      }

      if (
        ["COMPLETED", "FAILED"].indexOf(
          data.TranscriptionJob.TranscriptionJobStatus
        ) > -1
      ) {
        cb(null, data);
        return;
      }

      setTimeout(() => {
        pollTranscription(jobName, cb);
      }, 5000);
    }
  );
};

const transcribe = (s3Url, jobName, cb) => {
  transcribeClient.startTranscriptionJob(
    {
      TranscriptionJobName: jobName,
      Media: {
        MediaFileUri: s3Url,
      },
      LanguageCode: "en-US",
      Subtitles: {
        Formats: ["srt"],
      },
    },
    (error) => {
      if (error) {
        cb(error);
        return;
      }

      pollTranscription(jobName, cb);
    }
  );
};

exports.default = transcribe;
