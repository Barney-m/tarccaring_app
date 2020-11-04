import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {

  final String _endpoint = 'http://192.168.43.203:8000/api/user/login';

  Future signIn(Map<String, String> formData) async {
    try {

      var credentials = {
        'user_id' : formData["id"].trim() ?? null,
        'password' : formData["password"] ?? null,
      };

      var res = await http.post(
        _endpoint,
        body: jsonEncode(credentials),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        }
      );

      return json.decode(res.body);
    } catch (e) {
      return null;
    }
  }
}
