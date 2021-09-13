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

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String nickname;
  final int uid;
  final String portrait;
  final String bio;
  final TemporalDate birth;
  final int gender;
  final String city;
  final String profession;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const User._internal(
      {@required this.id,
      this.nickname,
      this.uid,
      this.portrait,
      this.bio,
      this.birth,
      this.gender,
      this.city,
      this.profession});

  factory User(
      {String id,
      String nickname,
      int uid,
      String portrait,
      String bio,
      TemporalDate birth,
      int gender,
      String city,
      String profession}) {
    return User._internal(
        id: id == null ? UUID.getUUID() : id,
        nickname: nickname,
        uid: uid,
        portrait: portrait,
        bio: bio,
        birth: birth,
        gender: gender,
        city: city,
        profession: profession);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        nickname == other.nickname &&
        uid == other.uid &&
        portrait == other.portrait &&
        bio == other.bio &&
        birth == other.birth &&
        gender == other.gender &&
        city == other.city &&
        profession == other.profession;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("nickname=" + "$nickname" + ", ");
    buffer.write("uid=" + (uid != null ? uid.toString() : "null") + ", ");
    buffer.write("portrait=" + "$portrait" + ", ");
    buffer.write("bio=" + "$bio" + ", ");
    buffer.write("birth=" + (birth != null ? birth.format() : "null") + ", ");
    buffer.write(
        "gender=" + (gender != null ? gender.toString() : "null") + ", ");
    buffer.write("city=" + "$city" + ", ");
    buffer.write("profession=" + "$profession");
    buffer.write("}");

    return buffer.toString();
  }

  User copyWith(
      {String id,
      String nickname,
      int uid,
      String portrait,
      String bio,
      TemporalDate birth,
      int gender,
      String city,
      String profession}) {
    return User(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        uid: uid ?? this.uid,
        portrait: portrait ?? this.portrait,
        bio: bio ?? this.bio,
        birth: birth ?? this.birth,
        gender: gender ?? this.gender,
        city: city ?? this.city,
        profession: profession ?? this.profession);
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nickname = json['nickname'],
        uid = (json['uid'] as num)?.toInt(),
        portrait = json['portrait'],
        bio = json['bio'],
        birth = json['birth'] != null
            ? TemporalDate.fromString(json['birth'])
            : null,
        gender = (json['gender'] as num)?.toInt(),
        city = json['city'],
        profession = json['profession'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'uid': uid,
        'portrait': portrait,
        'bio': bio,
        'birth': birth?.format(),
        'gender': gender,
        'city': city,
        'profession': profession
      };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField NICKNAME = QueryField(fieldName: "nickname");
  static final QueryField UID = QueryField(fieldName: "uid");
  static final QueryField PORTRAIT = QueryField(fieldName: "portrait");
  static final QueryField BIO = QueryField(fieldName: "bio");
  static final QueryField BIRTH = QueryField(fieldName: "birth");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField CITY = QueryField(fieldName: "city");
  static final QueryField PROFESSION = QueryField(fieldName: "profession");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";

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
        key: User.NICKNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.UID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.PORTRAIT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.BIO,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.BIRTH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.GENDER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.CITY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.PROFESSION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();

  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}
