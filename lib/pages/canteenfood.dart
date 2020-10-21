import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CanteenFood extends StatefulWidget {
  @override
  _CanteenFood createState() => _CanteenFood();
}

class _CanteenFood extends State<CanteenFood> {
  Future<void> _logoutUser(BuildContext context) {}

  bool isSwitched = false;

  File _image;

  Future getImage(bool isCamera) async {
    var image;
    if (isCamera) {
      image = await ImagePicker().getImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().getImage(source: ImageSource.gallery);
    }

    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Canteen Food'),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
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
                        defaultPadding * 1.5, 50, defaultPadding * 1.5, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultPadding / 2, 150, defaultPadding / 2, 100),
                          //margin: EdgeInsets.all(defaultPadding / 2),
                          child: Column(children: <Widget>[
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,

                                decoration: new InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 60,horizontal: 10),
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
                          top: 30.0,
                          left: 10.0,
                          right: 10.0,
                          child: DropDownField(
                            itemsVisibleInDropdown: 3,
                            required: true,
                            controller: canteenSelected,
                            hintText: "Canteen",
                            enabled: true,
                            items: canteens,
                            onValueChanged: (value) {
                              setState(() {
                                selectCanteen = value;
                              });
                            },
                          ),
                        ),
                        Positioned(
                            top: 470.0,
                            left: 20.0,
                            right: 80.0,
                            child: FlatButton(
                              child: Text(
                                'UPLOAD PHOTO',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.grey[100],
                              onPressed: () {
                                getImage(false);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            )),
                        Positioned(
                          top: 470.0,
                          left: 270.0,
                          right: 20.0,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              getImage(true);
                            },
                          ),
                        ),
                        Positioned(
                          top: 120.0,
                          left: 10.0,
                          right: 10.0,
                          child: Text('Comment:'),
                        ),
                        Positioned(
                          top: 330.0,
                          left: 50.0,
                          right: 50.0,
                          child: _image == null
                              ? Container(
                            height: 120,
                            width: 500.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                            ),
                          )
                              : Image.file(
                            _image,
                            height: 120,
                            width: 500.0,
                          ),
                        ),
                        Positioned(
                          bottom: 50.0,
                          left: 10.0,
                          right: 10.0,
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

final canteenSelected = TextEditingController();
String selectCanteen = "";

List<String> canteens = [
  "Red Brick Canteen",
  "Yum Yum Cafeteria",
  "Canteen 3",
];
