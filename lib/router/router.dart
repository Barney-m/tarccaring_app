import 'package:flutter/material.dart';
import 'package:tarccaring_app/pages/login.dart';
import 'package:tarccaring_app/pages/registration.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/pages/auth_main.dart';
import 'package:tarccaring_app/pages/intro.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Login());
    case RegistrationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => Registration());
    case AuthMainRoute:
      return MaterialPageRoute(builder: (BuildContext context) => AuthMain());
    case IntroPageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Intro());
    default:
      return MaterialPageRoute(builder: (BuildContext context) => Login());
  }
}
