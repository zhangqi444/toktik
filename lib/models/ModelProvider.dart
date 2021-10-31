/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Comment.dart';
import 'Like.dart';
import 'Music.dart';
import 'Post.dart';
import 'Share.dart';
import 'User.dart';
import 'View.dart';

export 'Comment.dart';
export 'Like.dart';
export 'ModelAttributeTypes.dart';
export 'Music.dart';
export 'Post.dart';
export 'Share.dart';
export 'User.dart';
export 'View.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "f46541b219feddae4a2aba1c78d3a0b5";
  @override
  List<ModelSchema> modelSchemas = [
    Comment.schema,
    Like.schema,
    Music.schema,
    Post.schema,
    Share.schema,
    User.schema,
    View.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Comment":
        {
          return Comment.classType;
        }
        break;
      case "Like":
        {
          return Like.classType;
        }
        break;
      case "Music":
        {
          return Music.classType;
        }
        break;
      case "Post":
        {
          return Post.classType;
        }
        break;
      case "Share":
        {
          return Share.classType;
        }
        break;
      case "User":
        {
          return User.classType;
        }
        break;
      case "View":
        {
          return View.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
}
