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


/** This is an auto generated class representing the NotInterested type in your schema. */
@immutable
class NotInterested extends Model {
  static const classType = const _NotInterestedModelType();
  final String id;
  final User? _user;
  final Post? _post;
  final User? _targetUser;
  final String? _type;

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
  
  User? get targetUser {
    return _targetUser;
  }
  
  String? get type {
    return _type;
  }
  
  const NotInterested._internal({required this.id, user, post, targetUser, type}): _user = user, _post = post, _targetUser = targetUser, _type = type;
  
  factory NotInterested({String? id, User? user, Post? post, User? targetUser, String? type}) {
    return NotInterested._internal(
      id: id == null ? UUID.getUUID() : id,
      user: user,
      post: post,
      targetUser: targetUser,
      type: type);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotInterested &&
      id == other.id &&
      _user == other._user &&
      _post == other._post &&
      _targetUser == other._targetUser &&
      _type == other._type;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("NotInterested {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null") + ", ");
    buffer.write("targetUser=" + (_targetUser != null ? _targetUser!.toString() : "null") + ", ");
    buffer.write("type=" + "$_type");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  NotInterested copyWith({String? id, User? user, Post? post, User? targetUser, String? type}) {
    return NotInterested(
      id: id ?? this.id,
      user: user ?? this.user,
      post: post ?? this.post,
      targetUser: targetUser ?? this.targetUser,
      type: type ?? this.type);
  }
  
  NotInterested.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _targetUser = json['targetUser']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['targetUser']['serializedData']))
        : null,
      _type = json['type'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user?.toJson(), 'post': _post?.toJson(), 'targetUser': _targetUser?.toJson(), 'type': _type
  };

  static final QueryField ID = QueryField(fieldName: "notInterested.id");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField TARGETUSER = QueryField(
    fieldName: "targetUser",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField TYPE = QueryField(fieldName: "type");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "NotInterested";
    modelSchemaDefinition.pluralName = "NotInteresteds";
    
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
      key: NotInterested.USER,
      isRequired: false,
      targetName: "notInterestedUserId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: NotInterested.POST,
      isRequired: false,
      targetName: "notInterestedPostId",
      ofModelName: (Post).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: NotInterested.TARGETUSER,
      isRequired: false,
      targetName: "notInterestedTargetUserId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: NotInterested.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _NotInterestedModelType extends ModelType<NotInterested> {
  const _NotInterestedModelType();
  
  @override
  NotInterested fromJson(Map<String, dynamic> jsonData) {
    return NotInterested.fromJson(jsonData);
  }
}