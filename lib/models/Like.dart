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

/** This is an auto generated class representing the Like type in your schema. */
@immutable
class Like extends Model {
  static const classType = const _LikeModelType();
  final String id;
  final User user;
  final Post post;
  final bool value;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Like._internal({@required this.id, this.user, this.post, this.value});

  factory Like({String id, User user, Post post, bool value}) {
    return Like._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        post: post,
        value: value);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Like &&
        id == other.id &&
        user == other.user &&
        post == other.post &&
        value == other.value;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Like {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("post=" + (post != null ? post.toString() : "null") + ", ");
    buffer.write("value=" + (value != null ? value.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Like copyWith({String id, User user, Post post, bool value}) {
    return Like(
        id: id ?? this.id,
        user: user ?? this.user,
        post: post ?? this.post,
        value: value ?? this.value);
  }

  Like.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        post = json['post'] != null
            ? Post.fromJson(new Map<String, dynamic>.from(json['post']))
            : null,
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'post': post?.toJson(),
        'value': value
      };

  static final QueryField ID = QueryField(fieldName: "like.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField POST = QueryField(
      fieldName: "post",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Post).toString()));
  static final QueryField VALUE = QueryField(fieldName: "value");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Like";
    modelSchemaDefinition.pluralName = "Likes";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Like.USER,
        isRequired: false,
        targetName: "likeUserId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Like.POST,
        isRequired: false,
        targetName: "likePostId",
        ofModelName: (Post).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Like.VALUE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));
  });
}

class _LikeModelType extends ModelType<Like> {
  const _LikeModelType();

  @override
  Like fromJson(Map<String, dynamic> jsonData) {
    return Like.fromJson(jsonData);
  }
}
