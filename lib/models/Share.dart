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


/** This is an auto generated class representing the Share type in your schema. */
@immutable
class Share extends Model {
  static const classType = const _ShareModelType();
  final String id;
  final String? _to;
  final String? _shareUserId;
  final String? _sharePostId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get to {
    return _to;
  }
  
  String get shareUserId {
    try {
      return _shareUserId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get sharePostId {
    try {
      return _sharePostId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const Share._internal({required this.id, to, required shareUserId, required sharePostId}): _to = to, _shareUserId = shareUserId, _sharePostId = sharePostId;
  
  factory Share({String? id, String? to, required String shareUserId, required String sharePostId}) {
    return Share._internal(
      id: id == null ? UUID.getUUID() : id,
      to: to,
      shareUserId: shareUserId,
      sharePostId: sharePostId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Share &&
      id == other.id &&
      _to == other._to &&
      _shareUserId == other._shareUserId &&
      _sharePostId == other._sharePostId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Share {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("to=" + "$_to" + ", ");
    buffer.write("shareUserId=" + "$_shareUserId" + ", ");
    buffer.write("sharePostId=" + "$_sharePostId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Share copyWith({String? id, String? to, String? shareUserId, String? sharePostId}) {
    return Share(
      id: id ?? this.id,
      to: to ?? this.to,
      shareUserId: shareUserId ?? this.shareUserId,
      sharePostId: sharePostId ?? this.sharePostId);
  }
  
  Share.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _to = json['to'],
      _shareUserId = json['shareUserId'],
      _sharePostId = json['sharePostId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'to': _to, 'shareUserId': _shareUserId, 'sharePostId': _sharePostId
  };

  static final QueryField ID = QueryField(fieldName: "share.id");
  static final QueryField TO = QueryField(fieldName: "to");
  static final QueryField SHAREUSERID = QueryField(fieldName: "shareUserId");
  static final QueryField SHAREPOSTID = QueryField(fieldName: "sharePostId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Share";
    modelSchemaDefinition.pluralName = "Shares";
    
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
      key: Share.TO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Share.SHAREUSERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Share.SHAREPOSTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ShareModelType extends ModelType<Share> {
  const _ShareModelType();
  
  @override
  Share fromJson(Map<String, dynamic> jsonData) {
    return Share.fromJson(jsonData);
  }
}