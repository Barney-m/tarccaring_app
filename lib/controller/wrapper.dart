import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/shared_prefs.dart';
import 'package:tarccaring_app/users/management/management_nav_controller.dart';
import 'package:tarccaring_app/utils/api.dart';
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
    getRenderPage();
  }

  Future<void> getRenderPage() async {
    bool loginState = await getLoginState();

    var result = await APIService().getMethod('tokenValidation');
    var message = json.decode(result.body);
    int role = await getRoleID();
    bool firstTimeState = await getFirstTimeState();
    print(message);
    if (firstTimeState != null) {
      if (loginState != null) {
        if(message['error'] != null){
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
