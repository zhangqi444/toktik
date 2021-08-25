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
  final int commentCount;
  final int likeCount;
  final String attachments;
  final int shareCount;

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
      this.commentCount,
      this.likeCount,
      this.attachments,
      this.shareCount});

  factory Post(
      {String id,
      String text,
      User user,
      Music music,
      int commentCount,
      int likeCount,
      String attachments,
      int shareCount}) {
    return Post._internal(
        id: id == null ? UUID.getUUID() : id,
        text: text,
        user: user,
        music: music,
        commentCount: commentCount,
        likeCount: likeCount,
        attachments: attachments,
        shareCount: shareCount);
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
        commentCount == other.commentCount &&
        likeCount == other.likeCount &&
        attachments == other.attachments &&
        shareCount == other.shareCount;
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
    buffer.write("commentCount=" +
        (commentCount != null ? commentCount.toString() : "null") +
        ", ");
    buffer.write("likeCount=" +
        (likeCount != null ? likeCount.toString() : "null") +
        ", ");
    buffer.write("attachments=" + "$attachments" + ", ");
    buffer.write(
        "shareCount=" + (shareCount != null ? shareCount.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Post copyWith(
      {String id,
      String text,
      User user,
      Music music,
      int commentCount,
      int likeCount,
      String attachments,
      int shareCount}) {
    return Post(
        id: id ?? this.id,
        text: text ?? this.text,
        user: user ?? this.user,
        music: music ?? this.music,
        commentCount: commentCount ?? this.commentCount,
        likeCount: likeCount ?? this.likeCount,
        attachments: attachments ?? this.attachments,
        shareCount: shareCount ?? this.shareCount);
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
        commentCount = json['commentCount'],
        likeCount = json['likeCount'],
        attachments = json['attachments'],
        shareCount = json['shareCount'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'user': user?.toJson(),
        'music': music?.toJson(),
        'commentCount': commentCount,
        'likeCount': likeCount,
        'attachments': attachments,
        'shareCount': shareCount
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
  static final QueryField COMMENTCOUNT = QueryField(fieldName: "commentCount");
  static final QueryField LIKECOUNT = QueryField(fieldName: "likeCount");
  static final QueryField ATTACHMENTS = QueryField(fieldName: "attachments");
  static final QueryField SHARECOUNT = QueryField(fieldName: "shareCount");
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
        key: Post.COMMENTCOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.LIKECOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.ATTACHMENTS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.SHARECOUNT,
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
