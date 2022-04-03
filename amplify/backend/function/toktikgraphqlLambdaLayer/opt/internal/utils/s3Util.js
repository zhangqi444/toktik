const AWS = require('aws-sdk');
const axios = require('axios');
const s3 = new AWS.S3();
const imageType = require('image-type');

const listObjects = (bucket, prefix, param = {}) => {
    return new Promise((resolve, reject) => {
        s3.listObjects({
            ...param,
            Bucket: bucket, 
            Prefix: prefix,
        }, function(err, data) {
            if(err) reject(err, err.stack); // an error occurred
            else     resolve(data);  
        });
    });
}

const putObjectFromUrl = (url, bucket, region, path, param) => {
    return new Promise((resolve, reject) => {
        axios.get(url, {
            decompress: false,
            // Ref: https://stackoverflow.com/a/61621094/4050261
            responseType: 'arraybuffer',
        }).then(async (resp) => {
            if (!resp.data) return;
            const fileType = imageType(resp.data);
            if (fileType && fileType.mime.startsWith('image') && !path.endsWith(fileType.ext)) {
                path = `${path.split('.')[0]}.${fileType.ext}`;
            }
            const res = await putObject(resp.data, bucket, region, path, param);
            resolve(res);
        }).catch(error => reject(error));
    });
}

const putObject = (data, bucket, region, path, param = {}) => {
    return new Promise((resolve, reject) => {
        s3.putObject({
            ...param,
            Body: data,
            Key: path,
            Bucket: bucket
        }, function (error, data) {
            if (error) {
                reject(error);
            } else {
                resolve(`https://${bucket || process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME}.s3.${region || process.env.REGION}.amazonaws.com/${path}`);
            }
        });
    });
}

const getObject = (params) => {
    return new Promise((resolve, reject) => {
        s3.getObject(params, async (error, data) => {
            if(error) reject(error);
            else {
                data = new Buffer.from(data.Body).toString()
                resolve(data);
            }
        });
    })
}

module.exports = {
    putObject,
    putObjectFromUrl,
    getObject,
    listObjects,
}
