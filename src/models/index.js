// @ts-check
import { initSchema } from '@aws-amplify/datastore';
import { schema } from './schema';

const ModelAttributeTypes = {
  "BINARY": "binary",
  "BINARY_SET": "binarySet",
  "BOOL": "bool",
  "LIST": "list",
  "MAP": "map",
  "NUMBER": "number",
  "NUMBER_SET": "numberSet",
  "STRING": "string",
  "STRING_SET": "stringSet",
  "NULL": "_null"
};

const { User, Music, View, Post, Like, Share, Comment, ModelPostExConnection, PostEx } = initSchema(schema);

export {
  User,
  Music,
  View,
  Post,
  Like,
  Share,
  Comment,
  ModelAttributeTypes,
  ModelPostExConnection,
  PostEx
};