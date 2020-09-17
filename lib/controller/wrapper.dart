import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/shared_prefs.dart';

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
    bool firstTimeState = await getFirstTimeState();

    if (firstTimeState != null) {
      if (loginState != null) {
        Navigator.pushReplacementNamed(context, UserNavigationRoute);
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
