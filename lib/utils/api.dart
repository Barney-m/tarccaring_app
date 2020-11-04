import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarccaring_app/shared_prefs.dart';

class APIService{
  final String _url = 'http://192.168.43.203:8000/api/user/';

  postMethod(data, endpoint) async{
    var fullUrl = _url + endpoint;
    return http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }
    );
  }

  getMethod(endpoint) async{
    var fullUrl = _url + endpoint;
    String token = await getAPIToken();
    return http.get(
      fullUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer $token',
      }
    );
  }
}