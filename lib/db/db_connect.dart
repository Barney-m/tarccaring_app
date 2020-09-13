import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future login(Map<String, String> formData) async {}
}

/*
  Future getData() async{
    var url = 'https://tarccaring.000webhostapp.com/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  @override
  void initState() {
    getData();
  }
*/
