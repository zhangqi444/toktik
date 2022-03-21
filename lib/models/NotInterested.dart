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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the NotInterested type in your schema. */
@immutable
class NotInterested extends Model {
  static const classType = const _NotInterestedModelType();
  final String id;
  final String? _notInterestedUserId;
  final String? _notInterestedPostId;
  final String? _notInterestedTargetUserId;
  final String? _type;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  String? get type {
    return _type;
  }
  
  const NotInterested._internal({required this.id, notInterestedUserId, notInterestedPostId, notInterestedTargetUserId, type}): _notInterestedUserId = notInterestedUserId, _notInterestedPostId = notInterestedPostId, _notInterestedTargetUserId = notInterestedTargetUserId, _type = type;
  
  factory NotInterested({String? id, String? notInterestedUserId, String? notInterestedPostId, String? notInterestedTargetUserId, String? type}) {
    return NotInterested._internal(
      id: id == null ? UUID.getUUID() : id,
      notInterestedUserId: notInterestedUserId,
      notInterestedPostId: notInterestedPostId,
      notInterestedTargetUserId: notInterestedTargetUserId,
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
      _notInterestedUserId == other._notInterestedUserId &&
      _notInterestedPostId == other._notInterestedPostId &&
      _notInterestedTargetUserId == other._notInterestedTargetUserId &&
      _type == other._type;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("NotInterested {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("notInterestedUserId=" + "$_notInterestedUserId" + ", ");
    buffer.write("notInterestedPostId=" + "$_notInterestedPostId" + ", ");
    buffer.write("notInterestedTargetUserId=" + "$_notInterestedTargetUserId" + ", ");
    buffer.write("type=" + "$_type");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  NotInterested copyWith({String? id, String? notInterestedUserId, String? notInterestedPostId, String? notInterestedTargetUserId, String? type}) {
    return NotInterested(
      id: id ?? this.id,
      notInterestedUserId: notInterestedUserId ?? this.notInterestedUserId,
      notInterestedPostId: notInterestedPostId ?? this.notInterestedPostId,
      notInterestedTargetUserId: notInterestedTargetUserId ?? this.notInterestedTargetUserId,
      type: type ?? this.type);
  }
  
  NotInterested.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _notInterestedUserId = json['notInterestedUserId'],
      _notInterestedPostId = json['notInterestedPostId'],
      _notInterestedTargetUserId = json['notInterestedTargetUserId'],
      _type = json['type'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'notInterestedUserId': _notInterestedUserId, 'notInterestedPostId': _notInterestedPostId, 'notInterestedTargetUserId': _notInterestedTargetUserId, 'type': _type
  };

  static final QueryField ID = QueryField(fieldName: "notInterested.id");
  static final QueryField NOTINTERESTEDUSERID = QueryField(fieldName: "notInterestedUserId");
  static final QueryField NOTINTERESTEDPOSTID = QueryField(fieldName: "notInterestedPostId");
  static final QueryField NOTINTERESTEDTARGETUSERID = QueryField(fieldName: "notInterestedTargetUserId");
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