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


/** This is an auto generated class representing the Share type in your schema. */
@immutable
class Share extends Model {
  static const classType = const _ShareModelType();
  final String id;
  final String? _to;
  final User? _user;
  final Post? _post;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get to {
    return _to;
  }
  
  User? get user {
    return _user;
  }
  
  Post? get post {
    return _post;
  }
  
  const Share._internal({required this.id, to, user, post}): _to = to, _user = user, _post = post;
  
  factory Share({String? id, String? to, User? user, Post? post}) {
    return Share._internal(
      id: id == null ? UUID.getUUID() : id,
      to: to,
      user: user,
      post: post);
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
      _user == other._user &&
      _post == other._post;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Share {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("to=" + "$_to" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Share copyWith({String? id, String? to, User? user, Post? post}) {
    return Share(
      id: id ?? this.id,
      to: to ?? this.to,
      user: user ?? this.user,
      post: post ?? this.post);
  }
  
  Share.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _to = json['to'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'to': _to, 'user': _user?.toJson(), 'post': _post?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "share.id");
  static final QueryField TO = QueryField(fieldName: "to");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Share.USER,
      isRequired: false,
      targetName: "shareUserId",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Share.POST,
      isRequired: false,
      targetName: "sharePostId",
      ofModelName: (Post).toString()
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