import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future signIn(Map<String, String> formData) async {
    try {
      String id = formData["id"].trim() ?? null;
      String password = formData["password"] ?? null;
    } catch (e) {
      return null;
    }
  }
}
