module.exports.constants = {
    ENV: {
        PROD: 'prod',
        STAGING: 'staging',
    },
    GRAPHQL_MODEL_NAME: {
        LIKE: 'Like',
        VIEW: 'View',
        POST: 'Post',
        SHARE: 'Share',
        COMMENT: 'Comment',
        USER: 'User',
    },
    GRAPHQL_SORTIER: "SORTIER",
    GRAPHQL_MODEL_SORT_DIRECTION: {
        DESC: "DESC",
        ASC: "ASC",
    },
    NOT_INTERESTED_TYPE: {
        USER: 'USER',
        POST: 'POST',
    },
    USER_TYPE: {
        IMPORTED: "IMPORTED",
        DEFAULT: "DEFAULT",
    },
    POST_STATUS: {
        INITIALIZED: "INITIALIZED",
    },
    S3: {
        TOKTIK_BUCKET_USER_PORTRAIT_IMAGES_PATH: 'user-portrait-images',
        TOKTIK_VIDEOS_PATH: 'videos',
        STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME: "toktik-storage-55239e9360500-staging",
        STORAGE_S3TOKTIKSTORAGED847E71C_BUCKETNAME: "toktik-storage-d847e71c175430-prod",
    }
};