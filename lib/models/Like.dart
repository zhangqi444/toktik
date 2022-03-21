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


/** This is an auto generated class representing the Like type in your schema. */
@immutable
class Like extends Model {
  static const classType = const _LikeModelType();
  final String id;
  final String? _likeUserId;
  final String? _likePostId;
  final bool? _value;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get likeUserId {
    try {
      return _likeUserId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get likePostId {
    try {
      return _likePostId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get value {
    return _value;
  }
  
  const Like._internal({required this.id, required likeUserId, required likePostId, value}): _likeUserId = likeUserId, _likePostId = likePostId, _value = value;
  
  factory Like({String? id, required String likeUserId, required String likePostId, bool? value}) {
    return Like._internal(
      id: id == null ? UUID.getUUID() : id,
      likeUserId: likeUserId,
      likePostId: likePostId,
      value: value);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Like &&
      id == other.id &&
      _likeUserId == other._likeUserId &&
      _likePostId == other._likePostId &&
      _value == other._value;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Like {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("likeUserId=" + "$_likeUserId" + ", ");
    buffer.write("likePostId=" + "$_likePostId" + ", ");
    buffer.write("value=" + (_value != null ? _value!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Like copyWith({String? id, String? likeUserId, String? likePostId, bool? value}) {
    return Like(
      id: id ?? this.id,
      likeUserId: likeUserId ?? this.likeUserId,
      likePostId: likePostId ?? this.likePostId,
      value: value ?? this.value);
  }
  
  Like.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _likeUserId = json['likeUserId'],
      _likePostId = json['likePostId'],
      _value = json['value'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'likeUserId': _likeUserId, 'likePostId': _likePostId, 'value': _value
  };

  static final QueryField ID = QueryField(fieldName: "like.id");
  static final QueryField LIKEUSERID = QueryField(fieldName: "likeUserId");
  static final QueryField LIKEPOSTID = QueryField(fieldName: "likePostId");
  static final QueryField VALUE = QueryField(fieldName: "value");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Like";
    modelSchemaDefinition.pluralName = "Likes";
    
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
      key: Like.LIKEUSERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Like.LIKEPOSTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Like.VALUE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
  });
}

class _LikeModelType extends ModelType<Like> {
  const _LikeModelType();
  
  @override
  Like fromJson(Map<String, dynamic> jsonData) {
    return Like.fromJson(jsonData);
  }
}