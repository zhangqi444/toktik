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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Post type in your schema. */
@immutable
class Post extends Model {
  static const classType = const _PostModelType();
  final String id;
  final String? _text;
  final String? _attachments;
  final int? _likeCount;
  final int? _commentCount;
  final int? _shareCount;
  final String? _postUserId;
  final int? _viewCount;
  final String? _description;
  final String? _formatType;
  final String? _source;
  final String? _postCategoryId;
  final List<String>? _postTagIds;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get text {
    return _text;
  }
  
  String? get attachments {
    return _attachments;
  }
  
  int? get likeCount {
    return _likeCount;
  }
  
  int? get commentCount {
    return _commentCount;
  }
  
  int? get shareCount {
    return _shareCount;
  }
  
  String? get postUserId {
    return _postUserId;
  }
  
  int? get viewCount {
    return _viewCount;
  }
  
  String? get description {
    return _description;
  }
  
  String? get formatType {
    return _formatType;
  }
  
  String? get source {
    return _source;
  }
  
  String? get postCategoryId {
    return _postCategoryId;
  }
  
  List<String>? get postTagIds {
    return _postTagIds;
  }
  
  const Post._internal({required this.id, text, attachments, likeCount, commentCount, shareCount, postUserId, viewCount, description, formatType, source, postCategoryId, postTagIds}): _text = text, _attachments = attachments, _likeCount = likeCount, _commentCount = commentCount, _shareCount = shareCount, _postUserId = postUserId, _viewCount = viewCount, _description = description, _formatType = formatType, _source = source, _postCategoryId = postCategoryId, _postTagIds = postTagIds;
  
  factory Post({String? id, String? text, String? attachments, int? likeCount, int? commentCount, int? shareCount, String? postUserId, int? viewCount, String? description, String? formatType, String? source, String? postCategoryId, List<String>? postTagIds}) {
    return Post._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      attachments: attachments,
      likeCount: likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
      postUserId: postUserId,
      viewCount: viewCount,
      description: description,
      formatType: formatType,
      source: source,
      postCategoryId: postCategoryId,
      postTagIds: postTagIds != null ? List<String>.unmodifiable(postTagIds) : postTagIds);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
      id == other.id &&
      _text == other._text &&
      _attachments == other._attachments &&
      _likeCount == other._likeCount &&
      _commentCount == other._commentCount &&
      _shareCount == other._shareCount &&
      _postUserId == other._postUserId &&
      _viewCount == other._viewCount &&
      _description == other._description &&
      _formatType == other._formatType &&
      _source == other._source &&
      _postCategoryId == other._postCategoryId &&
      DeepCollectionEquality().equals(_postTagIds, other._postTagIds);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("attachments=" + "$_attachments" + ", ");
    buffer.write("likeCount=" + (_likeCount != null ? _likeCount!.toString() : "null") + ", ");
    buffer.write("commentCount=" + (_commentCount != null ? _commentCount!.toString() : "null") + ", ");
    buffer.write("shareCount=" + (_shareCount != null ? _shareCount!.toString() : "null") + ", ");
    buffer.write("postUserId=" + "$_postUserId" + ", ");
    buffer.write("viewCount=" + (_viewCount != null ? _viewCount!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("formatType=" + "$_formatType" + ", ");
    buffer.write("source=" + "$_source" + ", ");
    buffer.write("postCategoryId=" + "$_postCategoryId" + ", ");
    buffer.write("postTagIds=" + (_postTagIds != null ? _postTagIds!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({String? id, String? text, String? attachments, int? likeCount, int? commentCount, int? shareCount, String? postUserId, int? viewCount, String? description, String? formatType, String? source, String? postCategoryId, List<String>? postTagIds}) {
    return Post(
      id: id ?? this.id,
      text: text ?? this.text,
      attachments: attachments ?? this.attachments,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      postUserId: postUserId ?? this.postUserId,
      viewCount: viewCount ?? this.viewCount,
      description: description ?? this.description,
      formatType: formatType ?? this.formatType,
      source: source ?? this.source,
      postCategoryId: postCategoryId ?? this.postCategoryId,
      postTagIds: postTagIds ?? this.postTagIds);
  }
  
  Post.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _attachments = json['attachments'],
      _likeCount = (json['likeCount'] as num?)?.toInt(),
      _commentCount = (json['commentCount'] as num?)?.toInt(),
      _shareCount = (json['shareCount'] as num?)?.toInt(),
      _postUserId = json['postUserId'],
      _viewCount = (json['viewCount'] as num?)?.toInt(),
      _description = json['description'],
      _formatType = json['formatType'],
      _source = json['source'],
      _postCategoryId = json['postCategoryId'],
      _postTagIds = json['postTagIds']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'attachments': _attachments, 'likeCount': _likeCount, 'commentCount': _commentCount, 'shareCount': _shareCount, 'postUserId': _postUserId, 'viewCount': _viewCount, 'description': _description, 'formatType': _formatType, 'source': _source, 'postCategoryId': _postCategoryId, 'postTagIds': _postTagIds
  };

  static final QueryField ID = QueryField(fieldName: "post.id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField ATTACHMENTS = QueryField(fieldName: "attachments");
  static final QueryField LIKECOUNT = QueryField(fieldName: "likeCount");
  static final QueryField COMMENTCOUNT = QueryField(fieldName: "commentCount");
  static final QueryField SHARECOUNT = QueryField(fieldName: "shareCount");
  static final QueryField POSTUSERID = QueryField(fieldName: "postUserId");
  static final QueryField VIEWCOUNT = QueryField(fieldName: "viewCount");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField FORMATTYPE = QueryField(fieldName: "formatType");
  static final QueryField SOURCE = QueryField(fieldName: "source");
  static final QueryField POSTCATEGORYID = QueryField(fieldName: "postCategoryId");
  static final QueryField POSTTAGIDS = QueryField(fieldName: "postTagIds");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";
    
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
      key: Post.TEXT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.ATTACHMENTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.LIKECOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.COMMENTCOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.SHARECOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTUSERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.VIEWCOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.FORMATTYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.SOURCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTCATEGORYID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTTAGIDS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}

class _PostModelType extends ModelType<Post> {
  const _PostModelType();
  
  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
}