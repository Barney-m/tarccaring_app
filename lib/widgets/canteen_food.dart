import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CanteenFoodForm extends StatelessWidget {
  const CanteenFoodForm({
    Key key,
    this.itemIndex,
  }) : super(key: key);

  final int itemIndex;

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 50,
          ),
          height: 50,
          child: TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: primaryColor),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(26.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.white),
                hintText: "Block H",
                fillColor: primaryColor),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 45,
          ),
          height: 50,
          child: TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: primaryColor),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                fillColor: Colors.grey),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 20,
          ),
          height: 70,
          child: TextField(
            decoration: InputDecoration(labelText: 'Upload Image'),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 20,
          ),
          height: 70,
          child: TextField(
            decoration: InputDecoration(labelText: 'Comment'),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 20,
          ),
          height: 70,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            color: primaryColor,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            onPressed: () {},
            child: Text(
              "SUBMIT".toUpperCase(),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


