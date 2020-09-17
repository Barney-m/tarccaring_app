import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/users/user/pages/homepage.dart';
import 'package:tarccaring_app/users/user/pages/feedback_history.dart';
import 'package:tarccaring_app/users/user/pages/user_setting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class UserNavController extends StatefulWidget {
  @override
  _UserNavController createState() => _UserNavController();
}

class _UserNavController extends State<UserNavController> {
  int _optionIndex = 0;

  final _navBarOption = [
    Homepage(),
    FeedbackHistory(),
    UserSetting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('Homepage'),
      ),
      backgroundColor: primaryColor,
      body: _navBarOption[_optionIndex],
      bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeInOutBack,
          animationDuration: Duration(milliseconds: 300),
          buttonBackgroundColor: secondaryColor,
          backgroundColor: Colors.white,
          color: secondaryColor,
          onTap: (index) {
            setState(() {
              _optionIndex = index;
            });
          },
          items: <Widget>[
            Icon(Icons.home, size: 20, color: Colors.black),
            Icon(Icons.list, size: 20, color: Colors.black),
            Icon(Icons.settings, size: 20, color: Colors.black),
          ]),
    );
  }
}
