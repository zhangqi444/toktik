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

/** This is an auto generated class representing the Music type in your schema. */
@immutable
class Music extends Model {
  static const classType = const _MusicModelType();
  final String? id;
  final String? url;
  final String? img;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id!;
  }

  const Music._internal({required this.id, this.url, this.img});

  factory Music({String? id, String? url, String? img}) {
    return Music._internal(
        id: id == null ? UUID.getUUID() : id, url: url, img: img);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Music &&
        id == other.id &&
        url == other.url &&
        img == other.img;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Music {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("url=" + "$url" + ", ");
    buffer.write("img=" + "$img");
    buffer.write("}");

    return buffer.toString();
  }

  Music copyWith({String? id, String? url, String? img}) {
    return Music(id: id ?? this.id, url: url ?? this.url, img: img ?? this.img);
  }

  Music.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        img = json['img'];

  Map<String, dynamic> toJson() => {'id': id, 'url': url, 'img': img};

  static final QueryField ID = QueryField(fieldName: "music.id");
  static final QueryField URL = QueryField(fieldName: "url");
  static final QueryField IMG = QueryField(fieldName: "img");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Music";
    modelSchemaDefinition.pluralName = "Music";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Music.URL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Music.IMG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _MusicModelType extends ModelType<Music> {
  const _MusicModelType();

  @override
  Music fromJson(Map<String, dynamic> jsonData) {
    return Music.fromJson(jsonData);
  }
}
