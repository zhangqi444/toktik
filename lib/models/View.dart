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


/** This is an auto generated class representing the View type in your schema. */
@immutable
class View extends Model {
  static const classType = const _ViewModelType();
  final String id;
  final String? _viewUserId;
  final String? _viewPostId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get viewUserId {
    try {
      return _viewUserId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get viewPostId {
    try {
      return _viewPostId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const View._internal({required this.id, required viewUserId, required viewPostId}): _viewUserId = viewUserId, _viewPostId = viewPostId;
  
  factory View({String? id, required String viewUserId, required String viewPostId}) {
    return View._internal(
      id: id == null ? UUID.getUUID() : id,
      viewUserId: viewUserId,
      viewPostId: viewPostId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is View &&
      id == other.id &&
      _viewUserId == other._viewUserId &&
      _viewPostId == other._viewPostId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("View {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("viewUserId=" + "$_viewUserId" + ", ");
    buffer.write("viewPostId=" + "$_viewPostId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  View copyWith({String? id, String? viewUserId, String? viewPostId}) {
    return View(
      id: id ?? this.id,
      viewUserId: viewUserId ?? this.viewUserId,
      viewPostId: viewPostId ?? this.viewPostId);
  }
  
  View.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _viewUserId = json['viewUserId'],
      _viewPostId = json['viewPostId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'viewUserId': _viewUserId, 'viewPostId': _viewPostId
  };

  static final QueryField ID = QueryField(fieldName: "view.id");
  static final QueryField VIEWUSERID = QueryField(fieldName: "viewUserId");
  static final QueryField VIEWPOSTID = QueryField(fieldName: "viewPostId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "View";
    modelSchemaDefinition.pluralName = "Views";
    
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
      key: View.VIEWUSERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: View.VIEWPOSTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ViewModelType extends ModelType<View> {
  const _ViewModelType();
  
  @override
  View fromJson(Map<String, dynamic> jsonData) {
    return View.fromJson(jsonData);
  }
}