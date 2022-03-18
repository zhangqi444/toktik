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


/** This is an auto generated class representing the Report type in your schema. */
@immutable
class Report extends Model {
  static const classType = const _ReportModelType();
  final String id;
  final String? _reason;
  final String? _description;
  final String? _status;
  final User? _user;
  final Post? _post;
  final String? _type;
  final String? _result;
  final User? _targetUser;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get reason {
    return _reason;
  }
  
  String? get description {
    return _description;
  }
  
  String? get status {
    return _status;
  }
  
  User? get user {
    return _user;
  }
  
  Post? get post {
    return _post;
  }
  
  String? get type {
    return _type;
  }
  
  String? get result {
    return _result;
  }
  
  User? get targetUser {
    return _targetUser;
  }
  
  const Report._internal({required this.id, reason, description, status, user, post, type, result, targetUser}): _reason = reason, _description = description, _status = status, _user = user, _post = post, _type = type, _result = result, _targetUser = targetUser;
  
  factory Report({String? id, String? reason, String? description, String? status, User? user, Post? post, String? type, String? result, User? targetUser}) {
    return Report._internal(
      id: id == null ? UUID.getUUID() : id,
      reason: reason,
      description: description,
      status: status,
      user: user,
      post: post,
      type: type,
      result: result,
      targetUser: targetUser);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Report &&
      id == other.id &&
      _reason == other._reason &&
      _description == other._description &&
      _status == other._status &&
      _user == other._user &&
      _post == other._post &&
      _type == other._type &&
      _result == other._result &&
      _targetUser == other._targetUser;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Report {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("reason=" + "$_reason" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null") + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("result=" + "$_result" + ", ");
    buffer.write("targetUser=" + (_targetUser != null ? _targetUser!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Report copyWith({String? id, String? reason, String? description, String? status, User? user, Post? post, String? type, String? result, User? targetUser}) {
    return Report(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      status: status ?? this.status,
      user: user ?? this.user,
      post: post ?? this.post,
      type: type ?? this.type,
      result: result ?? this.result,
      targetUser: targetUser ?? this.targetUser);
  }
  
  Report.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _reason = json['reason'],
      _description = json['description'],
      _status = json['status'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _type = json['type'],
      _result = json['result'],
      _targetUser = json['targetUser']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['targetUser']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'reason': _reason, 'description': _description, 'status': _status, 'user': _user?.toJson(), 'post': _post?.toJson(), 'type': _type, 'result': _result, 'targetUser': _targetUser?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "report.id");
  static final QueryField REASON = QueryField(fieldName: "reason");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField RESULT = QueryField(fieldName: "result");
  static final QueryField TARGETUSER = QueryField(
    fieldName: "targetUser",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Report";
    modelSchemaDefinition.pluralName = "Reports";
    
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
      key: Report.REASON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Report.USER,
      isRequired: false,
      targetName: "reportUserId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Report.POST,
      isRequired: false,
      targetName: "reportPostId",
      ofModelName: (Post).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.RESULT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Report.TARGETUSER,
      isRequired: false,
      targetName: "reportTargetUserId",
      ofModelName: (User).toString()
    ));
  });
}

class _ReportModelType extends ModelType<Report> {
  const _ReportModelType();
  
  @override
  Report fromJson(Map<String, dynamic> jsonData) {
    return Report.fromJson(jsonData);
  }
}