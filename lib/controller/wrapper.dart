import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/shared_prefs.dart';
import 'dart:io';
import 'package:tarccaring_app/users/management/management_nav_controller.dart';
import 'package:tarccaring_app/utils/api.dart';
import 'package:tarccaring_app/utils/connectivity.dart';
import 'dart:convert';

class Wrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Wrapper();
  }
}

class _Wrapper extends State {
  @override
  void initState() {
    super.initState();
    Connection().isConnected().then((internet){
      if(internet){
        getRenderPage();
      }
      else{
        setLoginState(false).then((_) {
                              removePublicState();
                              removeUserState();
                              Navigator.of(context).pushReplacementNamed(AuthMainRoute);
                            });
      }
    });
  }

  Future<void> getRenderPage() async {
    bool loginState = await getLoginState();
    var result;
    try{
      result = await APIService().getMethod('tokenValidation');
    } finally{
      //Token Validation Result
    }

    var message = json.decode(result.body);
    int role = await getRoleID();
    bool firstTimeState = await getFirstTimeState();
    if (firstTimeState != null) {
      if (loginState != null) {
        if(message['error'] != null || message['success'] == true){
          switch(role){
            case 2:
            case 3:
            case 4:
              Navigator.pushReplacementNamed(context, UserNavigationRoute);
              break;
            case 5:
              Navigator.pushReplacementNamed(context, ManagementNavigationRoute);
              break;
            default:
              setLoginState(false).then((_) {
                              removePublicState();
                              removeUserState();
                              Navigator.of(context).pushReplacementNamed(AuthMainRoute);
                            });
              break;
          }
        }
        else{
          setLoginState(false).then((_) {
                              removePublicState();
                              removeUserState();
                              Navigator.of(context).pushReplacementNamed(AuthMainRoute);
                            });
        }
      } else {
        Navigator.pushReplacementNamed(context, AuthMainRoute);
      }
    } else {
      Navigator.pushReplacementNamed(context, IntroPageRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
