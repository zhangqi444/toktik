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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Post type in your schema. */
@immutable
class Post extends Model {
  static const classType = const _PostModelType();
  final String id;
  final String? _text;
  final User? _user;
  final Music? _music;
  final String? _attachments;
  final int? _likeCount;
  final int? _commentCount;
  final int? _shareCount;
  final int? _viewCount;
  final String? _description;
  final String? _formatType;
  final String? _source;
  final Categorization? _categorization;
  final List<Tag>? _tags;
  final List<String>? _postTagIds;
  final bool? _isDeleted;
  final bool? _isBlocked;
  final Sortier? _sortier;
  final TemporalDateTime? _updatedAt;
  final TemporalDateTime? _createdAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get text {
    return _text;
  }
  
  User? get user {
    return _user;
  }
  
  Music? get music {
    return _music;
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
  
  Categorization? get categorization {
    return _categorization;
  }
  
  List<Tag>? get tags {
    return _tags;
  }
  
  List<String>? get postTagIds {
    return _postTagIds;
  }
  
  bool? get isDeleted {
    return _isDeleted;
  }
  
  bool? get isBlocked {
    return _isBlocked;
  }
  
  Sortier get sortier {
    try {
      return _sortier!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  const Post._internal({required this.id, text, user, music, attachments, likeCount, commentCount, shareCount, viewCount, description, formatType, source, categorization, tags, postTagIds, isDeleted, isBlocked, required sortier, updatedAt, createdAt}): _text = text, _user = user, _music = music, _attachments = attachments, _likeCount = likeCount, _commentCount = commentCount, _shareCount = shareCount, _viewCount = viewCount, _description = description, _formatType = formatType, _source = source, _categorization = categorization, _tags = tags, _postTagIds = postTagIds, _isDeleted = isDeleted, _isBlocked = isBlocked, _sortier = sortier, _updatedAt = updatedAt, _createdAt = createdAt;
  
  factory Post({String? id, String? text, User? user, Music? music, String? attachments, int? likeCount, int? commentCount, int? shareCount, int? viewCount, String? description, String? formatType, String? source, Categorization? categorization, List<Tag>? tags, List<String>? postTagIds, bool? isDeleted, bool? isBlocked, required Sortier sortier, TemporalDateTime? updatedAt, TemporalDateTime? createdAt}) {
    return Post._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      user: user,
      music: music,
      attachments: attachments,
      likeCount: likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
      viewCount: viewCount,
      description: description,
      formatType: formatType,
      source: source,
      categorization: categorization,
      tags: tags != null ? List<Tag>.unmodifiable(tags) : tags,
      postTagIds: postTagIds != null ? List<String>.unmodifiable(postTagIds) : postTagIds,
      isDeleted: isDeleted,
      isBlocked: isBlocked,
      sortier: sortier,
      updatedAt: updatedAt,
      createdAt: createdAt);
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
      _user == other._user &&
      _music == other._music &&
      _attachments == other._attachments &&
      _likeCount == other._likeCount &&
      _commentCount == other._commentCount &&
      _shareCount == other._shareCount &&
      _viewCount == other._viewCount &&
      _description == other._description &&
      _formatType == other._formatType &&
      _source == other._source &&
      _categorization == other._categorization &&
      DeepCollectionEquality().equals(_tags, other._tags) &&
      DeepCollectionEquality().equals(_postTagIds, other._postTagIds) &&
      _isDeleted == other._isDeleted &&
      _isBlocked == other._isBlocked &&
      _sortier == other._sortier &&
      _updatedAt == other._updatedAt &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("music=" + (_music != null ? _music!.toString() : "null") + ", ");
    buffer.write("attachments=" + "$_attachments" + ", ");
    buffer.write("likeCount=" + (_likeCount != null ? _likeCount!.toString() : "null") + ", ");
    buffer.write("commentCount=" + (_commentCount != null ? _commentCount!.toString() : "null") + ", ");
    buffer.write("shareCount=" + (_shareCount != null ? _shareCount!.toString() : "null") + ", ");
    buffer.write("viewCount=" + (_viewCount != null ? _viewCount!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("formatType=" + "$_formatType" + ", ");
    buffer.write("source=" + "$_source" + ", ");
    buffer.write("categorization=" + (_categorization != null ? _categorization!.toString() : "null") + ", ");
    buffer.write("postTagIds=" + (_postTagIds != null ? _postTagIds!.toString() : "null") + ", ");
    buffer.write("isDeleted=" + (_isDeleted != null ? _isDeleted!.toString() : "null") + ", ");
    buffer.write("isBlocked=" + (_isBlocked != null ? _isBlocked!.toString() : "null") + ", ");
    buffer.write("sortier=" + (_sortier != null ? enumToString(_sortier)! : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({String? id, String? text, User? user, Music? music, String? attachments, int? likeCount, int? commentCount, int? shareCount, int? viewCount, String? description, String? formatType, String? source, Categorization? categorization, List<Tag>? tags, List<String>? postTagIds, bool? isDeleted, bool? isBlocked, Sortier? sortier, TemporalDateTime? updatedAt, TemporalDateTime? createdAt}) {
    return Post(
      id: id ?? this.id,
      text: text ?? this.text,
      user: user ?? this.user,
      music: music ?? this.music,
      attachments: attachments ?? this.attachments,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      viewCount: viewCount ?? this.viewCount,
      description: description ?? this.description,
      formatType: formatType ?? this.formatType,
      source: source ?? this.source,
      categorization: categorization ?? this.categorization,
      tags: tags ?? this.tags,
      postTagIds: postTagIds ?? this.postTagIds,
      isDeleted: isDeleted ?? this.isDeleted,
      isBlocked: isBlocked ?? this.isBlocked,
      sortier: sortier ?? this.sortier,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt);
  }
  
  Post.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _music = json['music']?['serializedData'] != null
        ? Music.fromJson(new Map<String, dynamic>.from(json['music']['serializedData']))
        : null,
      _attachments = json['attachments'],
      _likeCount = (json['likeCount'] as num?)?.toInt(),
      _commentCount = (json['commentCount'] as num?)?.toInt(),
      _shareCount = (json['shareCount'] as num?)?.toInt(),
      _viewCount = (json['viewCount'] as num?)?.toInt(),
      _description = json['description'],
      _formatType = json['formatType'],
      _source = json['source'],
      _categorization = json['categorization']?['serializedData'] != null
        ? Categorization.fromJson(new Map<String, dynamic>.from(json['categorization']['serializedData']))
        : null,
      _tags = json['tags'] is List
        ? (json['tags'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Tag.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _postTagIds = json['postTagIds']?.cast<String>(),
      _isDeleted = json['isDeleted'],
      _isBlocked = json['isBlocked'],
      _sortier = enumFromString<Sortier>(json['sortier'], Sortier.values),
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'user': _user?.toJson(), 'music': _music?.toJson(), 'attachments': _attachments, 'likeCount': _likeCount, 'commentCount': _commentCount, 'shareCount': _shareCount, 'viewCount': _viewCount, 'description': _description, 'formatType': _formatType, 'source': _source, 'categorization': _categorization?.toJson(), 'tags': _tags?.map((Tag? e) => e?.toJson()).toList(), 'postTagIds': _postTagIds, 'isDeleted': _isDeleted, 'isBlocked': _isBlocked, 'sortier': enumToString(_sortier), 'updatedAt': _updatedAt?.format(), 'createdAt': _createdAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "post.id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField MUSIC = QueryField(
    fieldName: "music",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Music).toString()));
  static final QueryField ATTACHMENTS = QueryField(fieldName: "attachments");
  static final QueryField LIKECOUNT = QueryField(fieldName: "likeCount");
  static final QueryField COMMENTCOUNT = QueryField(fieldName: "commentCount");
  static final QueryField SHARECOUNT = QueryField(fieldName: "shareCount");
  static final QueryField VIEWCOUNT = QueryField(fieldName: "viewCount");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField FORMATTYPE = QueryField(fieldName: "formatType");
  static final QueryField SOURCE = QueryField(fieldName: "source");
  static final QueryField CATEGORIZATION = QueryField(
    fieldName: "categorization",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Categorization).toString()));
  static final QueryField TAGS = QueryField(
    fieldName: "tags",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Tag).toString()));
  static final QueryField POSTTAGIDS = QueryField(fieldName: "postTagIds");
  static final QueryField ISDELETED = QueryField(fieldName: "isDeleted");
  static final QueryField ISBLOCKED = QueryField(fieldName: "isBlocked");
  static final QueryField SORTIER = QueryField(fieldName: "sortier");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Post.USER,
      isRequired: false,
      targetName: "postUserId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Post.MUSIC,
      isRequired: false,
      targetName: "postMusicId",
      ofModelName: (Music).toString()
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Post.CATEGORIZATION,
      isRequired: false,
      targetName: "postCategorizationId",
      ofModelName: (Categorization).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Post.TAGS,
      isRequired: false,
      ofModelName: (Tag).toString(),
      associatedKey: Tag.POSTTAGSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTTAGIDS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.ISDELETED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.ISBLOCKED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.SORTIER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.UPDATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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