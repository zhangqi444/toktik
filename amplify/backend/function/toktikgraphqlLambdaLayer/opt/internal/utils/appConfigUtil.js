const AWS = require('aws-sdk');
const appConfig = new AWS.AppConfig();

const APP_CONFIG_APPLICATION_BREEZE = "Breeze";
const APP_CONFIG_CLIENT_ID = "breeze";

const APP_CONFIG_ENV = {
  PROD: 'prod',
};

const getConfiguration = (configuration, environment, param = {}) => {
  const params = {
    ...param,
    Application: APP_CONFIG_APPLICATION_BREEZE,
    ClientId: APP_CONFIG_CLIENT_ID,
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
  getConfiguration,
  APP_CONFIG_ENV,
}
