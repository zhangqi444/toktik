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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Comment type in your schema. */
@immutable
class Comment extends Model {
  static const classType = const _CommentModelType();
  final String id;
  final String? _text;
  final String? _commentUserId;
  final String? _commentPostId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get text {
    return _text;
  }
  
  String get commentUserId {
    try {
      return _commentUserId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get commentPostId {
    try {
      return _commentPostId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const Comment._internal({required this.id, text, required commentUserId, required commentPostId}): _text = text, _commentUserId = commentUserId, _commentPostId = commentPostId;
  
  factory Comment({String? id, String? text, required String commentUserId, required String commentPostId}) {
    return Comment._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      commentUserId: commentUserId,
      commentPostId: commentPostId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      id == other.id &&
      _text == other._text &&
      _commentUserId == other._commentUserId &&
      _commentPostId == other._commentPostId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("commentUserId=" + "$_commentUserId" + ", ");
    buffer.write("commentPostId=" + "$_commentPostId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? id, String? text, String? commentUserId, String? commentPostId}) {
    return Comment(
      id: id ?? this.id,
      text: text ?? this.text,
      commentUserId: commentUserId ?? this.commentUserId,
      commentPostId: commentPostId ?? this.commentPostId);
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _commentUserId = json['commentUserId'],
      _commentPostId = json['commentPostId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'commentUserId': _commentUserId, 'commentPostId': _commentPostId
  };

  static final QueryField ID = QueryField(fieldName: "comment.id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField COMMENTUSERID = QueryField(fieldName: "commentUserId");
  static final QueryField COMMENTPOSTID = QueryField(fieldName: "commentPostId");
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.TEXT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.COMMENTUSERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.COMMENTPOSTID,
      isRequired: true,
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