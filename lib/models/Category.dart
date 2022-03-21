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


/** This is an auto generated class representing the Category type in your schema. */
@immutable
class Category extends Model {
  static const classType = const _CategoryModelType();
  final String id;
  final String? _name;
  final bool? _isSubcategory;
  final String? _parentCategoryId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  bool? get isSubcategory {
    return _isSubcategory;
  }
  
  String? get parentCategoryId {
    return _parentCategoryId;
  }
  
  const Category._internal({required this.id, name, isSubcategory, parentCategoryId}): _name = name, _isSubcategory = isSubcategory, _parentCategoryId = parentCategoryId;
  
  factory Category({String? id, String? name, bool? isSubcategory, String? parentCategoryId}) {
    return Category._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      isSubcategory: isSubcategory,
      parentCategoryId: parentCategoryId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Category &&
      id == other.id &&
      _name == other._name &&
      _isSubcategory == other._isSubcategory &&
      _parentCategoryId == other._parentCategoryId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Category {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("isSubcategory=" + (_isSubcategory != null ? _isSubcategory!.toString() : "null") + ", ");
    buffer.write("parentCategoryId=" + "$_parentCategoryId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Category copyWith({String? id, String? name, bool? isSubcategory, String? parentCategoryId}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      isSubcategory: isSubcategory ?? this.isSubcategory,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId);
  }
  
  Category.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _isSubcategory = json['isSubcategory'],
      _parentCategoryId = json['parentCategoryId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'isSubcategory': _isSubcategory, 'parentCategoryId': _parentCategoryId
  };

  static final QueryField ID = QueryField(fieldName: "category.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ISSUBCATEGORY = QueryField(fieldName: "isSubcategory");
  static final QueryField PARENTCATEGORYID = QueryField(fieldName: "parentCategoryId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Category";
    modelSchemaDefinition.pluralName = "Categories";
    
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
      key: Category.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Category.ISSUBCATEGORY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Category.PARENTCATEGORYID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CategoryModelType extends ModelType<Category> {
  const _CategoryModelType();
  
  @override
  Category fromJson(Map<String, dynamic> jsonData) {
    return Category.fromJson(jsonData);
  }
}