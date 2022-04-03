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


/** This is an auto generated class representing the Categorization type in your schema. */
@immutable
class Categorization extends Model {
  static const classType = const _CategorizationModelType();
  final String id;
  final String? _name;
  final bool? _isSubcategorization;
  final String? _parentCategorizationId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  bool? get isSubcategorization {
    return _isSubcategorization;
  }
  
  String? get parentCategorizationId {
    return _parentCategorizationId;
  }
  
  const Categorization._internal({required this.id, name, isSubcategorization, parentCategorizationId}): _name = name, _isSubcategorization = isSubcategorization, _parentCategorizationId = parentCategorizationId;
  
  factory Categorization({String? id, String? name, bool? isSubcategorization, String? parentCategorizationId}) {
    return Categorization._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      isSubcategorization: isSubcategorization,
      parentCategorizationId: parentCategorizationId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Categorization &&
      id == other.id &&
      _name == other._name &&
      _isSubcategorization == other._isSubcategorization &&
      _parentCategorizationId == other._parentCategorizationId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Categorization {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("isSubcategorization=" + (_isSubcategorization != null ? _isSubcategorization!.toString() : "null") + ", ");
    buffer.write("parentCategorizationId=" + "$_parentCategorizationId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Categorization copyWith({String? id, String? name, bool? isSubcategorization, String? parentCategorizationId}) {
    return Categorization(
      id: id ?? this.id,
      name: name ?? this.name,
      isSubcategorization: isSubcategorization ?? this.isSubcategorization,
      parentCategorizationId: parentCategorizationId ?? this.parentCategorizationId);
  }
  
  Categorization.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _isSubcategorization = json['isSubcategorization'],
      _parentCategorizationId = json['parentCategorizationId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'isSubcategorization': _isSubcategorization, 'parentCategorizationId': _parentCategorizationId
  };

  static final QueryField ID = QueryField(fieldName: "categorization.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ISSUBCATEGORIZATION = QueryField(fieldName: "isSubcategorization");
  static final QueryField PARENTCATEGORIZATIONID = QueryField(fieldName: "parentCategorizationId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Categorization";
    modelSchemaDefinition.pluralName = "Categorizations";
    
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
      key: Categorization.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Categorization.ISSUBCATEGORIZATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Categorization.PARENTCATEGORIZATIONID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CategorizationModelType extends ModelType<Categorization> {
  const _CategorizationModelType();
  
  @override
  Categorization fromJson(Map<String, dynamic> jsonData) {
    return Categorization.fromJson(jsonData);
  }
}