import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/users/public/pages/homepage.dart';
import 'package:tarccaring_app/users/user/pages/feedback_history.dart';
import 'package:tarccaring_app/users/user/pages/user_setting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class UserNavController extends StatefulWidget {
  @override
  _UserNavController createState() => _UserNavController();
}

class _UserNavController extends State<UserNavController> {
  int _optionIndex = 0;

  final _title = [
    Text('Homepage'),
    Text('Setting'),
  ];

  final _navBarOption = [
    Homepage(),
    UserSetting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: _title[_optionIndex],
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: _navBarOption[_optionIndex],
      bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeInOutBack,
          animationDuration: Duration(milliseconds: 200),
          buttonBackgroundColor: Colors.white,
          backgroundColor: secondaryColor,
          color: Colors.white,
          onTap: (index) {
            setState(() {
              _optionIndex = index;
            });
          },
          items: <Widget>[
            Icon(Icons.home, size: 20, color: Colors.black),
            Icon(Icons.settings, size: 20, color: Colors.black),
          ]),
    );
  }
}
