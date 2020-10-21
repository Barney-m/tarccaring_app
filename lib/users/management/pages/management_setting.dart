import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/shared_prefs.dart';

class ManagementSetting extends StatefulWidget {
  @override
  _ManagementSetting createState() => _ManagementSetting();
}

class _ManagementSetting extends State<ManagementSetting> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: defaultPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(defaultPadding * 1.5, defaultPadding * 2, defaultPadding * 1.5, 0),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: defaultPadding * 1.5, top: defaultPadding / 3),
                        child: Text(
                          'About Us',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: defaultPadding / 2, right: defaultPadding / 2, top: defaultPadding / 2),
                        margin: EdgeInsets.only(top: defaultPadding * 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(defaultPadding / 2),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset('assets/images/logo/TARC_Logo.png'),
                            ),
                            Expanded(
                              child: Text(
                                'TARC Caring is an application that offers services to users to provide feedback anywhere and anytime.'
                                'This application developed and managed by Tunku Abdul Rahman Univercity College (TARUC).'
                              ),
                            ),
                          ]
                        ),
                      ),
                      Positioned(
                        bottom: 30.0,
                        left: 10.0,
                        right: 10.0,
                        child: FlatButton(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          color: primaryColor,
                          onPressed: () {
                            setLoginState(false).then((_) {
                              setID(null);
                              setRoleID(null);
                              setAPIToken(null);
                              Navigator.of(context).pushReplacementNamed(AuthMainRoute);
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
