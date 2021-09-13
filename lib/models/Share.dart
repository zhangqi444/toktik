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

/** This is an auto generated class representing the Share type in your schema. */
@immutable
class Share extends Model {
  static const classType = const _ShareModelType();
  final String id;
  final String to;
  final User user;
  final Post post;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Share._internal({@required this.id, this.to, this.user, this.post});

  factory Share({String id, String to, User user, Post post}) {
    return Share._internal(
        id: id == null ? UUID.getUUID() : id, to: to, user: user, post: post);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Share &&
        id == other.id &&
        to == other.to &&
        user == other.user &&
        post == other.post;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Share {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("to=" + "$to" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("post=" + (post != null ? post.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Share copyWith({String id, String to, User user, Post post}) {
    return Share(
        id: id ?? this.id,
        to: to ?? this.to,
        user: user ?? this.user,
        post: post ?? this.post);
  }

  Share.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        to = json['to'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        post = json['post'] != null
            ? Post.fromJson(new Map<String, dynamic>.from(json['post']))
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'to': to, 'user': user?.toJson(), 'post': post?.toJson()};

  static final QueryField ID = QueryField(fieldName: "share.id");
  static final QueryField TO = QueryField(fieldName: "to");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField POST = QueryField(
      fieldName: "post",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Post).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Share";
    modelSchemaDefinition.pluralName = "Shares";

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
        key: Share.TO,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Share.USER,
        isRequired: false,
        targetName: "shareUserId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Share.POST,
        isRequired: false,
        targetName: "sharePostId",
        ofModelName: (Post).toString()));
  });
}

class _ShareModelType extends ModelType<Share> {
  const _ShareModelType();

  @override
  Share fromJson(Map<String, dynamic> jsonData) {
    return Share.fromJson(jsonData);
  }
}
