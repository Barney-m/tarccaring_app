import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class User {
  final String user_id,
      email,
      pass,
      name,
      gender,
      image,
      nric_no,
      mobile_no,
      home_address,
      corr_address,
      session_join,
      status,
      faculty_id;
  final DateTime birth_date, last_modified;
  final Uint8List uuid;
  final int role_id;

  User(
      {@required this.user_id,
      @required this.email,
      @required this.pass,
      this.name,
      this.gender,
      this.image,
      this.nric_no,
      this.birth_date,
      this.mobile_no,
      this.home_address,
      this.corr_address,
      this.session_join,
      this.status,
      this.uuid,
      this.last_modified,
      this.role_id,
      this.faculty_id});

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'email': email,
      'pass': pass,
      'name': name,
      'gender': gender,
      'image': image,
      'nric_no': nric_no,
      'birth_date': birth_date,
      'mobile_no': mobile_no,
      'home_address': home_address,
      'corr_address': corr_address,
      'session_join': session_join,
      'status': status,
      'uuid': jsonEncode(uuid),
      'last_modified': last_modified,
      'role_id': role_id,
      'faculty_id': faculty_id,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'],
      email: map['email'],
      pass: map['pass'],
      name: map['name'],
      gender: map['gender'],
      image: map['image'],
      nric_no: map['nric_no'],
      birth_date: map['birth_date'],
      mobile_no: map['mobile_no'],
      home_address: map['home_address'],
      corr_address: map['corr_address'],
      session_join: map['session_join'],
      status: map['status'],
      uuid: jsonDecode(map['uuid']),
      last_modified: map['last_modified'],
      role_id: map['role_id'],
      faculty_id: map['faculty_id'],
    );
  }
}
