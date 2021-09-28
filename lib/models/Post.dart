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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Post type in your schema. */
@immutable
class Post extends Model {
  static const classType = const _PostModelType();
  final String id;
  final String text;
  final User user;
  final Music music;
  final String attachments;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int viewCount;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Post._internal(
      {@required this.id,
      this.text,
      this.user,
      this.music,
      this.attachments,
      this.likeCount,
      this.commentCount,
      this.shareCount,
      this.viewCount});

  factory Post(
      {String id,
      String text,
      User user,
      Music music,
      String attachments,
      int likeCount,
      int commentCount,
      int shareCount,
      int viewCount}) {
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
        text == other.text &&
        user == other.user &&
        music == other.music &&
        attachments == other.attachments &&
        likeCount == other.likeCount &&
        commentCount == other.commentCount &&
        shareCount == other.shareCount &&
        viewCount == other.viewCount;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$text" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("music=" + (music != null ? music.toString() : "null") + ", ");
    buffer.write("attachments=" + "$attachments" + ", ");
    buffer.write("likeCount=" +
        (likeCount != null ? likeCount.toString() : "null") +
        ", ");
    buffer.write("commentCount=" +
        (commentCount != null ? commentCount.toString() : "null") +
        ", ");
    buffer.write("shareCount=" +
        (shareCount != null ? shareCount.toString() : "null") +
        ", ");
    buffer.write(
        "viewCount=" + (viewCount != null ? viewCount.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Post copyWith(
      {String id,
      String text,
      User user,
      Music music,
      String attachments,
      int likeCount,
      int commentCount,
      int shareCount,
      int viewCount}) {
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
        text = json['text'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        music = json['music'] != null
            ? Music.fromJson(new Map<String, dynamic>.from(json['music']))
            : null,
        attachments = json['attachments'],
        likeCount = (json['likeCount'] as num)?.toInt(),
        commentCount = (json['commentCount'] as num)?.toInt(),
        shareCount = (json['shareCount'] as num)?.toInt(),
        viewCount = (json['viewCount'] as num)?.toInt();

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'user': user?.toJson(),
        'music': music?.toJson(),
        'attachments': attachments,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'viewCount': viewCount
      };

  static final QueryField ID = QueryField(fieldName: "post.id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField MUSIC = QueryField(
      fieldName: "music",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Music).toString()));
  static final QueryField ATTACHMENTS = QueryField(fieldName: "attachments");
  static final QueryField LIKECOUNT = QueryField(fieldName: "likeCount");
  static final QueryField COMMENTCOUNT = QueryField(fieldName: "commentCount");
  static final QueryField SHARECOUNT = QueryField(fieldName: "shareCount");
  static final QueryField VIEWCOUNT = QueryField(fieldName: "viewCount");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
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
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Post.USER,
        isRequired: false,
        targetName: "postUserId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Post.MUSIC,
        isRequired: false,
        targetName: "postMusicId",
        ofModelName: (Music).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.ATTACHMENTS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.LIKECOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.COMMENTCOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.SHARECOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.VIEWCOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));
  });
}

class _PostModelType extends ModelType<Post> {
  const _PostModelType();

  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
}
