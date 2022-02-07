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
  final User? _userId;
  final Post? _postId;
  final User? _targetUserId;
  final String? _notInterestedUserId;
  final String? _notInterestedPostId;
  final String? _notInterestedTargetUserId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  User? get userId {
    return _userId;
  }
  
  Post? get postId {
    return _postId;
  }
  
  User? get targetUserId {
    return _targetUserId;
  }
  
  String? get notInterestedUserId {
    return _notInterestedUserId;
  }
  
  String? get notInterestedPostId {
    return _notInterestedPostId;
  }
  
  String? get notInterestedTargetUserId {
    return _notInterestedTargetUserId;
  }
  
  const NotInterested._internal({required this.id, userId, postId, targetUserId, notInterestedUserId, notInterestedPostId, notInterestedTargetUserId}): _userId = userId, _postId = postId, _targetUserId = targetUserId, _notInterestedUserId = notInterestedUserId, _notInterestedPostId = notInterestedPostId, _notInterestedTargetUserId = notInterestedTargetUserId;
  
  factory NotInterested({String? id, User? userId, Post? postId, User? targetUserId, String? notInterestedUserId, String? notInterestedPostId, String? notInterestedTargetUserId}) {
    return NotInterested._internal(
      id: id == null ? UUID.getUUID() : id,
      userId: userId,
      postId: postId,
      targetUserId: targetUserId,
      notInterestedUserId: notInterestedUserId,
      notInterestedPostId: notInterestedPostId,
      notInterestedTargetUserId: notInterestedTargetUserId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotInterested &&
      id == other.id &&
      _userId == other._userId &&
      _postId == other._postId &&
      _targetUserId == other._targetUserId &&
      _notInterestedUserId == other._notInterestedUserId &&
      _notInterestedPostId == other._notInterestedPostId &&
      _notInterestedTargetUserId == other._notInterestedTargetUserId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("NotInterested {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + (_userId != null ? _userId!.toString() : "null") + ", ");
    buffer.write("postId=" + (_postId != null ? _postId!.toString() : "null") + ", ");
    buffer.write("targetUserId=" + (_targetUserId != null ? _targetUserId!.toString() : "null") + ", ");
    buffer.write("notInterestedUserId=" + "$_notInterestedUserId" + ", ");
    buffer.write("notInterestedPostId=" + "$_notInterestedPostId" + ", ");
    buffer.write("notInterestedTargetUserId=" + "$_notInterestedTargetUserId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  NotInterested copyWith({String? id, User? userId, Post? postId, User? targetUserId, String? notInterestedUserId, String? notInterestedPostId, String? notInterestedTargetUserId}) {
    return NotInterested(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      targetUserId: targetUserId ?? this.targetUserId,
      notInterestedUserId: notInterestedUserId ?? this.notInterestedUserId,
      notInterestedPostId: notInterestedPostId ?? this.notInterestedPostId,
      notInterestedTargetUserId: notInterestedTargetUserId ?? this.notInterestedTargetUserId);
  }
  
  NotInterested.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userId = json['userId']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['userId']['serializedData']))
        : null,
      _postId = json['postId']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['postId']['serializedData']))
        : null,
      _targetUserId = json['targetUserId']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['targetUserId']['serializedData']))
        : null,
      _notInterestedUserId = json['notInterestedUserId'],
      _notInterestedPostId = json['notInterestedPostId'],
      _notInterestedTargetUserId = json['notInterestedTargetUserId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': _userId?.toJson(), 'postId': _postId?.toJson(), 'targetUserId': _targetUserId?.toJson(), 'notInterestedUserId': _notInterestedUserId, 'notInterestedPostId': _notInterestedPostId, 'notInterestedTargetUserId': _notInterestedTargetUserId
  };

  static final QueryField ID = QueryField(fieldName: "notInterested.id");
  static final QueryField USERID = QueryField(
    fieldName: "userId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField POSTID = QueryField(
    fieldName: "postId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField TARGETUSERID = QueryField(
    fieldName: "targetUserId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField NOTINTERESTEDUSERID = QueryField(fieldName: "notInterestedUserId");
  static final QueryField NOTINTERESTEDPOSTID = QueryField(fieldName: "notInterestedPostId");
  static final QueryField NOTINTERESTEDTARGETUSERID = QueryField(fieldName: "notInterestedTargetUserId");
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
      key: NotInterested.USERID,
      isRequired: false,
      targetName: "notInterestedUserIdId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: NotInterested.POSTID,
      isRequired: false,
      targetName: "notInterestedPostIdId",
      ofModelName: (Post).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: NotInterested.TARGETUSERID,
      isRequired: false,
      targetName: "notInterestedTargetUserIdId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: NotInterested.NOTINTERESTEDUSERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: NotInterested.NOTINTERESTEDPOSTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: NotInterested.NOTINTERESTEDTARGETUSERID,
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