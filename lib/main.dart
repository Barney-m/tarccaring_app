import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/router.dart';
import 'package:tarccaring_app/controller/wrapper.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: 34.0,
            fontWeight: FontWeight.w700,
          ),
          bodyText2: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: 16.0,
          ),
          subtitle1:TextStyle(
            fontFamily: "ProximaNova",
            fontSize: 22.0,
          )
        ),
      ),
      home:Wrapper()
    ),
  );
}
