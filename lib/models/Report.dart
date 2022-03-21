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


/** This is an auto generated class representing the Report type in your schema. */
@immutable
class Report extends Model {
  static const classType = const _ReportModelType();
  final String id;
  final String? _reason;
  final String? _description;
  final String? _status;
  final String? _type;
  final String? _result;
  final String? _reportUserId;
  final String? _reportPostId;
  final String? _reportTargetUserId;

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
  
  String? get type {
    return _type;
  }
  
  String? get result {
    return _result;
  }
  
  String? get reportUserId {
    return _reportUserId;
  }
  
  String? get reportPostId {
    return _reportPostId;
  }
  
  String? get reportTargetUserId {
    return _reportTargetUserId;
  }
  
  const Report._internal({required this.id, reason, description, status, type, result, reportUserId, reportPostId, reportTargetUserId}): _reason = reason, _description = description, _status = status, _type = type, _result = result, _reportUserId = reportUserId, _reportPostId = reportPostId, _reportTargetUserId = reportTargetUserId;
  
  factory Report({String? id, String? reason, String? description, String? status, String? type, String? result, String? reportUserId, String? reportPostId, String? reportTargetUserId}) {
    return Report._internal(
      id: id == null ? UUID.getUUID() : id,
      reason: reason,
      description: description,
      status: status,
      type: type,
      result: result,
      reportUserId: reportUserId,
      reportPostId: reportPostId,
      reportTargetUserId: reportTargetUserId);
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
      _type == other._type &&
      _result == other._result &&
      _reportUserId == other._reportUserId &&
      _reportPostId == other._reportPostId &&
      _reportTargetUserId == other._reportTargetUserId;
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
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("result=" + "$_result" + ", ");
    buffer.write("reportUserId=" + "$_reportUserId" + ", ");
    buffer.write("reportPostId=" + "$_reportPostId" + ", ");
    buffer.write("reportTargetUserId=" + "$_reportTargetUserId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Report copyWith({String? id, String? reason, String? description, String? status, String? type, String? result, String? reportUserId, String? reportPostId, String? reportTargetUserId}) {
    return Report(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      status: status ?? this.status,
      type: type ?? this.type,
      result: result ?? this.result,
      reportUserId: reportUserId ?? this.reportUserId,
      reportPostId: reportPostId ?? this.reportPostId,
      reportTargetUserId: reportTargetUserId ?? this.reportTargetUserId);
  }
  
  Report.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _reason = json['reason'],
      _description = json['description'],
      _status = json['status'],
      _type = json['type'],
      _result = json['result'],
      _reportUserId = json['reportUserId'],
      _reportPostId = json['reportPostId'],
      _reportTargetUserId = json['reportTargetUserId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'reason': _reason, 'description': _description, 'status': _status, 'type': _type, 'result': _result, 'reportUserId': _reportUserId, 'reportPostId': _reportPostId, 'reportTargetUserId': _reportTargetUserId
  };

  static final QueryField ID = QueryField(fieldName: "report.id");
  static final QueryField REASON = QueryField(fieldName: "reason");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField RESULT = QueryField(fieldName: "result");
  static final QueryField REPORTUSERID = QueryField(fieldName: "reportUserId");
  static final QueryField REPORTPOSTID = QueryField(fieldName: "reportPostId");
  static final QueryField REPORTTARGETUSERID = QueryField(fieldName: "reportTargetUserId");
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.REPORTUSERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.REPORTPOSTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Report.REPORTTARGETUSERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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