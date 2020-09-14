import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/campus_facilities.dart';
import 'package:tarccaring_app/widgets/homepage_card.dart';
import 'package:tarccaring_app/widgets/search_box.dart';
import 'package:tarccaring_app/model/feedback_types.dart';

class CampusFacilities extends StatefulWidget{
  @override
  _CampusFacilities createState() => _CampusFacilities();
}

class _CampusFacilities extends State<CampusFacilities> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('Campus Facilities'),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            SizedBox(height: defaultPadding / 2),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value){
                      setState(() {
                        isSwitched=value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),

                  CampusFacilitiesForm(itemIndex: 1),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
