import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';

class CampusFacilitiesForm extends StatelessWidget {
  const CampusFacilitiesForm({
    Key key,
    this.itemIndex,
  }) : super(key: key);

  final int itemIndex;

  int indexIncrement() => this.itemIndex + 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        //Campus Facilities

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
        //Campus Facilities
        //Canteen Food
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
        //Canteen Food
        //Education Quality
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
        //Education Qaulity
        //Service Attitude
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
        //Service Attitude
      ],
    );
  }
}
