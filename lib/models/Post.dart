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
  
  const Post._internal({required this.id, text, user, music, attachments, likeCount, commentCount, shareCount, viewCount}): _text = text, _user = user, _music = music, _attachments = attachments, _likeCount = likeCount, _commentCount = commentCount, _shareCount = shareCount, _viewCount = viewCount;
  
  factory Post({String? id, String? text, User? user, Music? music, String? attachments, int? likeCount, int? commentCount, int? shareCount, int? viewCount}) {
    return Post._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      user: user,
      music: music,
      attachments: attachments,
      likeCount: likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
      viewCount: viewCount);
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
      _viewCount == other._viewCount;
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
    buffer.write("viewCount=" + (_viewCount != null ? _viewCount!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({String? id, String? text, User? user, Music? music, String? attachments, int? likeCount, int? commentCount, int? shareCount, int? viewCount}) {
    return Post(
      id: id ?? this.id,
      text: text ?? this.text,
      user: user ?? this.user,
      music: music ?? this.music,
      attachments: attachments ?? this.attachments,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      viewCount: viewCount ?? this.viewCount);
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
      _viewCount = (json['viewCount'] as num?)?.toInt();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'user': _user?.toJson(), 'music': _music?.toJson(), 'attachments': _attachments, 'likeCount': _likeCount, 'commentCount': _commentCount, 'shareCount': _shareCount, 'viewCount': _viewCount
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
  });
}

class _PostModelType extends ModelType<Post> {
  const _PostModelType();
  
  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
}