import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:tarccaring_app/pages/canteenfood.dart';
import 'package:tarccaring_app/utils/constants.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tarccaring_app/widgets/size_config.dart';

class ServiceAttitude extends StatefulWidget {
  @override
  _ServicesAttitude createState() => _ServicesAttitude();
}

class _ServicesAttitude extends State<ServiceAttitude> {
  Future<void> _logoutUser(BuildContext context) {}

  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Services Attitude'),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              'ANONYMOUSLY',
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        defaultPadding * 1.5, SizeConfig.blockSizeVertical * 6, defaultPadding * 1.5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultPadding / 2, SizeConfig.blockSizeVertical * 19, defaultPadding / 2, 100),
                          //margin: EdgeInsets.all(defaultPadding / 2),
                          child: Column(children: <Widget>[
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: new InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 170,horizontal: 10),
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
                          ]),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 3,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: DropDownField(
                            itemsVisibleInDropdown: 3,
                            required: true,
                            controller: serviceSelected,
                            hintText: "Services",
                            enabled: true,
                            items: services,
                            onValueChanged: (value) {
                              setState(() {
                                selectService = value;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 15.5,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: Text('Comment:'),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 70,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: FlatButton(
                            child: Text(
                              'SUBMIT',
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
