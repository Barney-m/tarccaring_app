import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthMain extends StatelessWidget {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SafeArea(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment(0.0, 0.0),
                            child: Image.asset(
                                'assets/images/logo/TARC_Caring_Logo.png'),
                          ),
                        ),
                        Text(
                          "TARC Caring",
                          style:
                              TextStyle(color: secondaryColor, fontSize: 30.0),
                        ),
                        Text(
                          "Care about you.",
                          style: TextStyle(
                              color: primaryColor, height: 1.5, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          width: deviceSize.width,
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: FlatButton(
                              color: primaryColor,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(ServiceAttitudeRoute);
                              }),
                        ),
                      ])))
        ],
      ),
    );
  }
}
