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

/** This is an auto generated class representing the View type in your schema. */
@immutable
class View extends Model {
  static const classType = const _ViewModelType();
  final String id;
  final Post post;
  final User user;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const View._internal({@required this.id, this.post, this.user});

  factory View({String id, Post post, User user}) {
    return View._internal(
        id: id == null ? UUID.getUUID() : id, post: post, user: user);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is View &&
        id == other.id &&
        post == other.post &&
        user == other.user;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("View {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("post=" + (post != null ? post.toString() : "null") + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  View copyWith({String id, Post post, User user}) {
    return View(
        id: id ?? this.id, post: post ?? this.post, user: user ?? this.user);
  }

  View.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        post = json['post'] != null
            ? Post.fromJson(new Map<String, dynamic>.from(json['post']))
            : null,
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'post': post?.toJson(), 'user': user?.toJson()};

  static final QueryField ID = QueryField(fieldName: "view.id");
  static final QueryField POST = QueryField(
      fieldName: "post",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Post).toString()));
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "View";
    modelSchemaDefinition.pluralName = "Views";

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
        key: View.POST,
        isRequired: false,
        targetName: "viewPostId",
        ofModelName: (Post).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: View.USER,
        isRequired: false,
        targetName: "viewUserId",
        ofModelName: (User).toString()));
  });
}

class _ViewModelType extends ModelType<View> {
  const _ViewModelType();

  @override
  View fromJson(Map<String, dynamic> jsonData) {
    return View.fromJson(jsonData);
  }
}
