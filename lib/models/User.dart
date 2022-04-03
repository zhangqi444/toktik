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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _nickname;
  final String? _portrait;
  final String? _bio;
  final TemporalDate? _birth;
  final int? _gender;
  final String? _city;
  final String? _profession;
  final String? _username;
  final String? _email;
  final String? _phoneNumber;
  final String? _authStatus;
  final String? _type;
  final String? _status;
  final bool? _isDeleted;
  final bool? _isBlocked;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get nickname {
    return _nickname;
  }
  
  String? get portrait {
    return _portrait;
  }
  
  String? get bio {
    return _bio;
  }
  
  TemporalDate? get birth {
    return _birth;
  }
  
  int? get gender {
    return _gender;
  }
  
  String? get city {
    return _city;
  }
  
  String? get profession {
    return _profession;
  }
  
  String? get username {
    return _username;
  }
  
  String? get email {
    return _email;
  }
  
  String? get phoneNumber {
    return _phoneNumber;
  }
  
  String? get authStatus {
    return _authStatus;
  }
  
  String? get type {
    return _type;
  }
  
  String? get status {
    return _status;
  }
  
  bool? get isDeleted {
    return _isDeleted;
  }
  
  bool? get isBlocked {
    return _isBlocked;
  }
  
  const User._internal({required this.id, nickname, portrait, bio, birth, gender, city, profession, username, email, phoneNumber, authStatus, type, status, isDeleted, isBlocked}): _nickname = nickname, _portrait = portrait, _bio = bio, _birth = birth, _gender = gender, _city = city, _profession = profession, _username = username, _email = email, _phoneNumber = phoneNumber, _authStatus = authStatus, _type = type, _status = status, _isDeleted = isDeleted, _isBlocked = isBlocked;
  
  factory User({String? id, String? nickname, String? portrait, String? bio, TemporalDate? birth, int? gender, String? city, String? profession, String? username, String? email, String? phoneNumber, String? authStatus, String? type, String? status, bool? isDeleted, bool? isBlocked}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      nickname: nickname,
      portrait: portrait,
      bio: bio,
      birth: birth,
      gender: gender,
      city: city,
      profession: profession,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      authStatus: authStatus,
      type: type,
      status: status,
      isDeleted: isDeleted,
      isBlocked: isBlocked);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _nickname == other._nickname &&
      _portrait == other._portrait &&
      _bio == other._bio &&
      _birth == other._birth &&
      _gender == other._gender &&
      _city == other._city &&
      _profession == other._profession &&
      _username == other._username &&
      _email == other._email &&
      _phoneNumber == other._phoneNumber &&
      _authStatus == other._authStatus &&
      _type == other._type &&
      _status == other._status &&
      _isDeleted == other._isDeleted &&
      _isBlocked == other._isBlocked;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("nickname=" + "$_nickname" + ", ");
    buffer.write("portrait=" + "$_portrait" + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("birth=" + (_birth != null ? _birth!.format() : "null") + ", ");
    buffer.write("gender=" + (_gender != null ? _gender!.toString() : "null") + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("profession=" + "$_profession" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("authStatus=" + "$_authStatus" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("isDeleted=" + (_isDeleted != null ? _isDeleted!.toString() : "null") + ", ");
    buffer.write("isBlocked=" + (_isBlocked != null ? _isBlocked!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? nickname, String? portrait, String? bio, TemporalDate? birth, int? gender, String? city, String? profession, String? username, String? email, String? phoneNumber, String? authStatus, String? type, String? status, bool? isDeleted, bool? isBlocked}) {
    return User(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      portrait: portrait ?? this.portrait,
      bio: bio ?? this.bio,
      birth: birth ?? this.birth,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      profession: profession ?? this.profession,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authStatus: authStatus ?? this.authStatus,
      type: type ?? this.type,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      isBlocked: isBlocked ?? this.isBlocked);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _nickname = json['nickname'],
      _portrait = json['portrait'],
      _bio = json['bio'],
      _birth = json['birth'] != null ? TemporalDate.fromString(json['birth']) : null,
      _gender = (json['gender'] as num?)?.toInt(),
      _city = json['city'],
      _profession = json['profession'],
      _username = json['username'],
      _email = json['email'],
      _phoneNumber = json['phoneNumber'],
      _authStatus = json['authStatus'],
      _type = json['type'],
      _status = json['status'],
      _isDeleted = json['isDeleted'],
      _isBlocked = json['isBlocked'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'nickname': _nickname, 'portrait': _portrait, 'bio': _bio, 'birth': _birth?.format(), 'gender': _gender, 'city': _city, 'profession': _profession, 'username': _username, 'email': _email, 'phoneNumber': _phoneNumber, 'authStatus': _authStatus, 'type': _type, 'status': _status, 'isDeleted': _isDeleted, 'isBlocked': _isBlocked
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField NICKNAME = QueryField(fieldName: "nickname");
  static final QueryField PORTRAIT = QueryField(fieldName: "portrait");
  static final QueryField BIO = QueryField(fieldName: "bio");
  static final QueryField BIRTH = QueryField(fieldName: "birth");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField CITY = QueryField(fieldName: "city");
  static final QueryField PROFESSION = QueryField(fieldName: "profession");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONENUMBER = QueryField(fieldName: "phoneNumber");
  static final QueryField AUTHSTATUS = QueryField(fieldName: "authStatus");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField ISDELETED = QueryField(fieldName: "isDeleted");
  static final QueryField ISBLOCKED = QueryField(fieldName: "isBlocked");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: User.NICKNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PORTRAIT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BIO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BIRTH,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFESSION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONENUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.AUTHSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ISDELETED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ISBLOCKED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}