const { getConfiguration, APP_CONFIG_ENV } = require('./appConfigUtil'); 

const FEATURE_FLAGS = {
  BREEZE_CATEGORY_EXPERIMENT: "inv6u7k",
};

const check = (config, actual) => {
  const { op, value } = config;

  switch (op) {
    case 'eq':
    return actual === value;
  default:
    return false;
}
}

const isEnabled = async (configName, metadata) => {
  let config = await getConfiguration(configName, APP_CONFIG_ENV.PROD);
  config = config && config.Content && JSON.parse(config.Content);

  if (!config || !config.enabled) return false;
  if(!metadata) return false;

  let flag = true;
  const { mobileAppVersion } = metadata;
  const keys = Object.keys(config);
  for (var i = 0; i < keys.length; i++) {
    const key = keys[i];
    switch (key) {
      case 'mobileAppVersion':
      flag = flag && check(config[key], mobileAppVersion);
      break;

    default:
      // code
      break;
  }

    if (!flag) break;
  }
  return flag;
}

module.exports = {
  isEnabled,
  FEATURE_FLAGS,
}
