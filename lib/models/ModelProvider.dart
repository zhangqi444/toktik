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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Comment.dart';
import 'Like.dart';
import 'Music.dart';
import 'NotInterested.dart';
import 'Post.dart';
import 'Report.dart';
import 'Share.dart';
import 'User.dart';
import 'View.dart';
import 'ModelPostExConnection.dart';
import 'PostEx.dart';

export 'Comment.dart';
export 'Like.dart';
export 'ModelAttributeTypes.dart';
export 'ModelPostExConnection.dart';
export 'Music.dart';
export 'NotInterested.dart';
export 'Post.dart';
export 'PostEx.dart';
export 'Report.dart';
export 'Share.dart';
export 'User.dart';
export 'View.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "d8f4261b8068c885c734448b8c9218f7";
  @override
  List<ModelSchema> modelSchemas = [Comment.schema, Like.schema, Music.schema, NotInterested.schema, Post.schema, Report.schema, Share.schema, User.schema, View.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
      case "Comment":
        return Comment.classType;
      case "Like":
        return Like.classType;
      case "Music":
        return Music.classType;
      case "NotInterested":
        return NotInterested.classType;
      case "Post":
        return Post.classType;
      case "Report":
        return Report.classType;
      case "Share":
        return Share.classType;
      case "User":
        return User.classType;
      case "View":
        return View.classType;
      default:
        throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
  }
}