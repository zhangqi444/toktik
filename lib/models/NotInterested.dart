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
  final User? _notInterestedUserId;
  final Post? _notInterestedPostId;
  final User? _notInterestedNotInterestedUserId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  User? get notInterestedUserId {
    return _notInterestedUserId;
  }
  
  Post? get notInterestedPostId {
    return _notInterestedPostId;
  }
  
  User? get notInterestedNotInterestedUserId {
    return _notInterestedNotInterestedUserId;
  }
  
  const NotInterested._internal({required this.id, notInterestedUserId, notInterestedPostId, notInterestedNotInterestedUserId}): _notInterestedUserId = notInterestedUserId, _notInterestedPostId = notInterestedPostId, _notInterestedNotInterestedUserId = notInterestedNotInterestedUserId;
  
  factory NotInterested({String? id, User? notInterestedUserId, Post? notInterestedPostId, User? notInterestedNotInterestedUserId}) {
    return NotInterested._internal(
      id: id == null ? UUID.getUUID() : id,
      notInterestedUserId: notInterestedUserId,
      notInterestedPostId: notInterestedPostId,
      notInterestedNotInterestedUserId: notInterestedNotInterestedUserId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotInterested &&
      id == other.id &&
      _notInterestedUserId == other._notInterestedUserId &&
      _notInterestedPostId == other._notInterestedPostId &&
      _notInterestedNotInterestedUserId == other._notInterestedNotInterestedUserId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("NotInterested {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("notInterestedUserId=" + (_notInterestedUserId != null ? _notInterestedUserId!.toString() : "null") + ", ");
    buffer.write("notInterestedPostId=" + (_notInterestedPostId != null ? _notInterestedPostId!.toString() : "null") + ", ");
    buffer.write("notInterestedNotInterestedUserId=" + (_notInterestedNotInterestedUserId != null ? _notInterestedNotInterestedUserId!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  NotInterested copyWith({String? id, User? notInterestedUserId, Post? notInterestedPostId, User? notInterestedNotInterestedUserId}) {
    return NotInterested(
      id: id ?? this.id,
      notInterestedUserId: notInterestedUserId ?? this.notInterestedUserId,
      notInterestedPostId: notInterestedPostId ?? this.notInterestedPostId,
      notInterestedNotInterestedUserId: notInterestedNotInterestedUserId ?? this.notInterestedNotInterestedUserId);
  }
  
  NotInterested.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _notInterestedUserId = json['notInterestedUserId']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['notInterestedUserId']['serializedData']))
        : null,
      _notInterestedPostId = json['notInterestedPostId']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['notInterestedPostId']['serializedData']))
        : null,
      _notInterestedNotInterestedUserId = json['notInterestedNotInterestedUserId']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['notInterestedNotInterestedUserId']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'notInterestedUserId': _notInterestedUserId?.toJson(), 'notInterestedPostId': _notInterestedPostId?.toJson(), 'notInterestedNotInterestedUserId': _notInterestedNotInterestedUserId?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "notInterested.id");
  static final QueryField NOTINTERESTEDUSERID = QueryField(
    fieldName: "notInterestedUserId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField NOTINTERESTEDPOSTID = QueryField(
    fieldName: "notInterestedPostId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField NOTINTERESTEDNOTINTERESTEDUSERID = QueryField(
    fieldName: "notInterestedNotInterestedUserId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
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
      key: NotInterested.NOTINTERESTEDUSERID,
      isRequired: false,
      targetName: "notInterestedNotInterestedUserIdId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: NotInterested.NOTINTERESTEDPOSTID,
      isRequired: false,
      targetName: "notInterestedNotInterestedPostIdId",
      ofModelName: (Post).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: NotInterested.NOTINTERESTEDNOTINTERESTEDUSERID,
      isRequired: false,
      targetName: "notInterestedNotInterestedNotInterestedUserIdId",
      ofModelName: (User).toString()
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