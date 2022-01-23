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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Comment type in your schema. */
@immutable
class Comment extends Model {
  static const classType = const _CommentModelType();
  final String id;
  final User? _user;
  final Post? _post;
  final String? _text;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  User? get user {
    return _user;
  }
  
  Post? get post {
    return _post;
  }
  
  String? get text {
    return _text;
  }
  
  const Comment._internal({required this.id, user, post, text}): _user = user, _post = post, _text = text;
  
  factory Comment({String? id, User? user, Post? post, String? text}) {
    return Comment._internal(
      id: id == null ? UUID.getUUID() : id,
      user: user,
      post: post,
      text: text);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      id == other.id &&
      _user == other._user &&
      _post == other._post &&
      _text == other._text;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null") + ", ");
    buffer.write("text=" + "$_text");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? id, User? user, Post? post, String? text}) {
    return Comment(
      id: id ?? this.id,
      user: user ?? this.user,
      post: post ?? this.post,
      text: text ?? this.text);
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _text = json['text'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user?.toJson(), 'post': _post?.toJson(), 'text': _text
  };

  static final QueryField ID = QueryField(fieldName: "comment.id");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField TEXT = QueryField(fieldName: "text");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Comment.USER,
      isRequired: false,
      targetName: "commentUserId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Comment.POST,
      isRequired: false,
      targetName: "commentPostId",
      ofModelName: (Post).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.TEXT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CommentModelType extends ModelType<Comment> {
  const _CommentModelType();
  
  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }
}