const { constants } = require('./index');

const CONFIG_CATEGORIZATION = "CONFIG_CATEGORIZATION";

const CATEGORIZATION = {
    BUSINESS_AND_STARTUP: "BUSINESS_AND_STARTUP",
    SCIENCE_AND_TECHNOLOGY: "SCIENCE_AND_TECHNOLOGY",
}

const STAGING = {
    CONFIG_CATEGORIZATION: {
        BUSINESS_AND_STARTUP: {
            id: "bcbd0e80-4a97-43f3-8f4b-5069f373c125",
        },
        SCIENCE_AND_TECHNOLOGY: {
            id: "adfa96db-3432-4fcc-9951-7d86db545cba",
        },
    }
};

const PROD = {
    CONFIG_CATEGORIZATION: {
        BUSINESS_AND_STARTUP: {
            id: "bcbd0e80-4a97-43f3-8f4b-5069f373c125",
        },
        SCIENCE_AND_TECHNOLOGY: {
            id: "adfa96db-3432-4fcc-9951-7d86db545cba",
        },
    }
};

const getConfig = (name, env = process.env.ENV) => {
    switch (env) {
        case constants.ENV.STAGING:
            return STAGING[name];
        case constants.ENV.PROD:
            return PROD[name];
        default:
            break;
    }
}

module.exports = {
    getConfig,
    CONFIG_CATEGORIZATION,
    CATEGORIZATION,
};

