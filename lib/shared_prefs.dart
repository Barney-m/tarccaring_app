import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<bool> getLoginState() async{
  final prefs = await SharedPreferences.getInstance();

  final loginState = prefs.getBool('loginState');
  return loginState;
}

Future<void> setLoginState(bool loginState) async{
  final prefs = await SharedPreferences.getInstance();

  if(loginState){
    prefs.setBool('loginState', true);
  }
  else{
    prefs.remove('loginState');
  }
}

Future<int> getRoleID() async{
  final prefs = await SharedPreferences.getInstance();

  return prefs.getInt("roleId");
}

Future<void> setRoleID(int _role) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt("firstTimeState", _role);
}

Future<String> getID() async{
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString("id");
}

Future<void> setID(String id) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("id", id);
}

Future<String> getAPIToken(String token) async{
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString("api_token");
}

Future<void> setAPIToken(String token) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

Future<bool> getFirstTimeState() async{
  final prefs = await SharedPreferences.getInstance();

  return prefs.getBool("firstTimeState");
}

Future<void> setFirstTimeState() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("firstTimeState", false);
}
