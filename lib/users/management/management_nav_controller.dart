import 'package:flutter/material.dart';
import 'package:tarccaring_app/users/management/pages/feedback.dart';
import 'package:tarccaring_app/users/management/pages/history.dart';
import 'package:tarccaring_app/users/management/pages/homepage.dart';
import 'package:tarccaring_app/users/management/pages/management_setting.dart';
import 'package:tarccaring_app/users/management/pages/priority.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ManagementNavController extends StatefulWidget {
  @override
  _ManagementNavController createState() => _ManagementNavController();
}

class _ManagementNavController extends State<ManagementNavController> {
  int _optionIndex = 0;

  final _title = [
    Text('Homepage'),
    Text('Feedback'),
    Text('Priority'),
    Text('History'),
    Text('Setting'),
  ];

  final _navBarOption = [
    ManagementHomepage(),
    ManagementFeedback(),
    PriorityPage(),
    ManagementHistory(),
    ManagementSetting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: _title[_optionIndex],
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.notifications),
        //     onPressed: () {},
        //   )
        // ],
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: _navBarOption[_optionIndex],
      bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 300),
          buttonBackgroundColor: Colors.white,
          backgroundColor: secondaryColor,
          color: Colors.white,
          height: 50,
          onTap: (index) {
            setState(() {
              _optionIndex = index;
            });
          },
          items: <Widget>[
            Icon(Icons.home, size: 20, color: Colors.black),
            Icon(Icons.list, size: 20, color: Colors.black),
            Icon(Icons.settings_ethernet, size: 20, color: Colors.black),
            Icon(Icons.history, size: 20, color: Colors.black),
            Icon(Icons.settings, size: 20, color: Colors.black),
          ]),
    );
  }
}
