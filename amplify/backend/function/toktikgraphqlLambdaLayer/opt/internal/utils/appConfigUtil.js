const AWS = require('aws-sdk');
const appConfig = new AWS.AppConfig();

const listObjects = (application, configuration, environment, clientId = "breeze", param = {}) => {
  const params = {
    ...param,
    Application: application,
    ClientId: clientId,
    Configuration: configuration,
    Environment: environment,
  }
  return new Promise(
    (resolve, reject) => {
      appConfig.getConfiguration(params, function (err, data) {
        if (err) reject(err); // an error occurred
        else resolve(data); // successful response
      });
    }
  );
}

module.exports = {
  listObjects,
}
