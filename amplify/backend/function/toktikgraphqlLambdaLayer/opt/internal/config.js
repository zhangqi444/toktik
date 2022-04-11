const { constants } = require('./index');

const CONFIG_CATEGORIZATION = "CONFIG_CATEGORIZATION";

const CATEGORIZATION = {
    BUSINESS_AND_STARTUP: "BUSINESS_AND_STARTUP",
    SCIENCE_AND_TECHNOLOGY: "SCIENCE_AND_TECHNOLOGY",
    INSPIRATION: "INSPIRATION",
    NEWS: "NEWS",
    LIFESTYLE_AND_FUN: "LIFESTYLE_AND_FUN",
    RECIPE: "RECIPE",
    FACTS: "FACTS",
    PARENTING: "PARENTING",
    HISTORY: "HISTORY",
    HOBBY: "HOBBY",
    LIFE_HACKS_OR_ADVICES: "LIFE_HACKS_OR_ADVICES",
}

const STAGING = {
    CONFIG_CATEGORIZATION: {
        BUSINESS_AND_STARTUP: {
            id: "bcbd0e80-4a97-43f3-8f4b-5069f373c125",
        },
        SCIENCE_AND_TECHNOLOGY: {
            id: "adfa96db-3432-4fcc-9951-7d86db545cba",
        },
        INSPIRATION: {
            id: "1560c2b4-2fff-4060-af95-9de7c12d1a61"
        },
        NEWS: {
            id: "df587364-4cd1-4037-bff1-2d96e7ed867e"
        },
        LIFESTYLE_AND_FUN: {
            id: "76992ab5-e260-4763-aef7-7137c86b957f"
        },
        RECIPE: {
            id: "0aeb931f-0580-4cc2-b84b-e5dcfc92642a"
        },
        FACTS: {
            id: "8300d280-3102-4fac-9b08-77d6855300eb"
        },
        PARENTING: {
            id: "d3aba08a-5a43-44a2-b364-138dc6f3d29e"
        },
        HISTORY: {
            id: "e3b5752a-1dce-43d8-b353-8e527ea05445"
        },
        HOBBY: {
            id: "5bbff3b7-8ae0-493e-b532-2d6704be3647"
        },
        LIFE_HACKS_OR_ADVICES: {
            id: "6c4a41e4-df61-42db-8a34-1a9e536c2757"
        },
    }
};

const PROD = {
    CONFIG_CATEGORIZATION: {
        BUSINESS_AND_STARTUP: {
            id: "3e24b044-93b2-46bc-8360-10f14d5cf088",
        },
        SCIENCE_AND_TECHNOLOGY: {
            id: "51726d60-3c61-4a6c-8130-94857625b7a4",
        },
        INSPIRATION: {
            id: "54c47990-6f4d-42a1-a81b-07afde7c24bb"
        },
        NEWS: {
            id: "54c7a33d-cbe6-47c0-bdba-dee83b5b27e6"
        },
        LIFESTYLE_AND_FUN: {
            id: "76992ab5-e260-4763-aef7-7137c86b957f"
        },
        RECIPE: {
            id: "f1e423b5-79de-472d-96ef-64ff3abccd00"
        },
        FACTS: {
            id: "643c7490-e100-4fdc-b3a1-61c0262f172a"
        },
        PARENTING: {
            id: "fe7c94cf-06de-4f4d-a5ef-ab2ca82f8529"
        },
        HISTORY: {
            id: "ef88b4a7-51b9-4a68-8bc4-8fecbaf927a0"
        },
        HOBBY: {
            id: "d74cbee3-9afe-4373-b53e-ac36a9e1b1b0"
        },
        LIFE_HACKS_OR_ADVICES: {
            id: "b5633c7e-de93-4d4d-a541-702085a5c415"
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

