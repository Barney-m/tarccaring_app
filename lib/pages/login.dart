import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarccaring_app/pages/auth_main.dart';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/shared_prefs.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/utils/auth.dart';
import 'package:tarccaring_app/widgets/form_field.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State {
  Map loaders;
  Map<String, String> formData;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    loaders = {"login": false};
    formData = {"id": "", "password": ""};
  }

  void toggleLoadingState() {
    this.setState(() {
      loaders["login"] = loaders["login"] == null ? true : !loaders["login"];
    });
  }

  Future<void> _loginPublic(BuildContext context) async{
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    String identifier;

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    setLoginState(true).then((_){
      setUUID(identifier);
      Navigator.of(context).pushReplacementNamed(PublicNavigationRoute);
    });
  }

  Future<void> _loginUser(BuildContext context) async {
    toggleLoadingState();
    _authService.signIn(formData).then((dynamic res) {
      toggleLoadingState();
      if(res['success']) {
        int role = res['role_id'];
        if(role > 1 && role < 5){
          setLoginState(true).then((_) {
            setID(res['id']);
            setRoleID(res['role_id']);
            setAPIToken(res['api_token']);
            Navigator.of(context).pushReplacementNamed(UserNavigationRoute);
          });
        }
        else if(role == 5){
          setLoginState(true).then((_) {
            setID(res['id']);
            setRoleID(res['role_id']);
            setAPIToken(res['api_token']);
            Navigator.of(context).pushReplacementNamed(ManagementNavigationRoute);
          });
        }
        else if(role == 1){
          setLoginState(true).then((_) {
            Navigator.of(context).pushReplacementNamed(PublicNavigationRoute);
          });
        }
      } 
      else {
        showDialog(
          context: context,
          builder: (BuildContext  context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              backgroundColor: primaryColor,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              contentTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
              title: Text("Invalid Credentials."),
              content: Text(res['message']),
            );
          },
        );
      }
    });
  }

  void changeFormData(key, value) {
    this.setState(() {
      formData[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Welcome Back",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .merge(TextStyle(color: blackColor)),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text("Sign in to continue",
                        style: Theme.of(context).textTheme.subtitle2.merge(
                            TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500))),
                    SizedBox(
                      height: 50.0,
                    ),
                    CustomFormField(
                      label: "ID",
                      onChange: changeFormData,
                      name: "id",
                    ),
                    CustomFormField(
                      label: "Password",
                      onChange: changeFormData,
                      name: "password",
                      obscureText: true,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              child: Text(
                                "Login as Guest",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                              onTap: (){
                                _loginPublic(context);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50.0,
                child: FlatButton(
                    color: primaryColor,
                    child: loaders["login"]
                        ? Container(
                            height: 27.0,
                            width: 27.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ))
                        : Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400),
                          ),
                    onPressed: () {
                      _loginUser(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
