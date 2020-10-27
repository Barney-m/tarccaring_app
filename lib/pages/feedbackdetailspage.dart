import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarccaring_app/pages/canteenfood.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tarccaring_app/widgets/campus_feedback_details_card.dart';
import 'package:tarccaring_app/widgets/canteen_food_details_card.dart';
import 'package:tarccaring_app/widgets/service_attitude_details_card.dart';
import 'package:tarccaring_app/widgets/education_quality_details_card.dart';
import 'package:tarccaring_app/widgets/size_config.dart';

class FeedbackDetailPage extends StatefulWidget {
  @override
  _FeedbackDetailPage createState() => _FeedbackDetailPage();
}

class _FeedbackDetailPage extends State<FeedbackDetailPage> {
  Future<void> _logoutUser(BuildContext context) {}


  bool isSwitched = false;

  String todo = '';

  /*void _cardType(){
    switch(todo){
      case 'Canteen Food Feedback' :
        CampusFeedbackDetailsCard();
        break;
      case 'Canteen Food Feedback' :
        CampusFeedbackDetailsCard();
        break;
      default:
        print('failed');
    }
  }*/

  _cardType(){
    switch(todo){
      case 'Campus Facility Feedback' :
        return CampusFeedbackDetailsCard();
        break;
      case 'Canteen Food Feedback' :
        return CanteenFeedbackDetailsCard();
        break;
      case 'Service Attitude Feedback' :
        return ServiceAttitudeDetailsCard();
        break;
      case 'Education Quality Feedback' :
        return EducationQualityDetailsCard();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {



    todo = ModalRoute.of(context).settings.arguments;

    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 19),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: AppBar(
                      title: Text(''),// You can add title here
                      leading: new IconButton(
                        icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () =>  Navigator.of(context)
                            .pushReplacementNamed(UserNavigationRoute),
                      ),
                      backgroundColor: primaryColor.withOpacity(0.3), //You can make this transparent
                      elevation: 0.0, //No shadow
                    ),),
                  Positioned(
                    top: SizeConfig.blockSizeVertical * 5,
                    left: SizeConfig.blockSizeVertical * 7,
                    right: SizeConfig.blockSizeVertical * 5,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: SizeConfig.blockSizeVertical * 1,
                            height: SizeConfig.blockSizeVertical * 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(
                                    "https://i.pinimg.com/originals/45/e6/49/45e64948063fcee9fed27800800e47ca.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Text(
                                'Student Name',
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Student ID',
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        defaultPadding * 1.5, SizeConfig.blockSizeVertical * 13,
                        defaultPadding * 1.5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultPadding / 2, 0, defaultPadding / 2, 0),
                          //margin: EdgeInsets.all(defaultPadding / 2),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultPadding / 2, SizeConfig.blockSizeVertical * 5, defaultPadding / 2, 0),
                          height: SizeConfig.blockSizeVertical * 42,
                          child: Column(children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Example Title 1',
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(),
                                  ),
                                  Text('27/9/2020'),
                                ],
                              ),
                            ),

                            Expanded(
                              child: _cardType(),
                              /*child: Row(
                                children: <Widget>[
                                  Expanded(flex: 1, child: SizedBox(),),
                                  Container(
                                    height: SizeConfig.blockSizeVertical * 10,
                                    width: SizeConfig.blockSizeVertical * 10,
                                    child: SvgPicture.asset(
                                      'assets/images/svg/campusfacilities.svg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(flex: 1, child: SizedBox(),),
                                  Text(todo),
                                  Expanded(flex: 1, child: SizedBox(),),
                                ],
                              ),*/
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text('Comment: '),
                                  Expanded(
                                    flex: 7,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                enabled: false,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      borderSide: new BorderSide(
                                          color: Colors.grey[100]),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text('Attachment: '),
                                  Expanded(
                                    flex: 7,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 45,
                          left: SizeConfig.blockSizeVertical * 10,
                          right: SizeConfig.blockSizeVertical * 10,
                          child: Container(
                              height: SizeConfig.blockSizeVertical * 15,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 63,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: FlatButton(
                            child: Text(
                              'Dismiss',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.blue[100],
                            onPressed: () {
                              _logoutUser(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 69,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: FlatButton(
                            child: Text(
                              'Approve',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.blue[200],
                            onPressed: () {
                              _logoutUser(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 75,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: FlatButton(
                            child: Text(
                              'Urgent',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: primaryColor,
                            onPressed: () {
                              _logoutUser(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final serviceSelected = TextEditingController();
String selectService = "";

List<String> services = [
  "DSA",
  "SRC",
  "Bangunan TSS",
  "Security Guard",
  "Management",
];

