import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EducationQuality extends StatefulWidget {
  @override
  _EducationQuality createState() => _EducationQuality();
}

class _EducationQuality extends State<EducationQuality> {
  Future<void> _logoutUser(BuildContext context) {}

  Future<List<dynamic>> fetchFeedbacks() async {
    var result = await http
        .get('https://randomuser.me/api/?results=10'); //TODO: Complete API
    return json.decode(result.body)['results'];
  }

  bool isSwitched = false;

  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Education Quality'),
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
                              defaultPadding / 2, 170, defaultPadding / 2, 100),
                          //margin: EdgeInsets.all(defaultPadding / 2),
                          child: Column(children: <Widget>[
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: new InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 60, horizontal: 10),
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
                          top: 332.0,
                          left: 10.0,
                          right: 10.0,
                          child: Text('Attachment:'),
                        ),
                        Positioned(
                          top: 352.0,
                          left: 10.0,
                          right: 10.0,
                          child: Text(
                              '(optional)',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        Positioned(
                          top: 140.0,
                          left: 10.0,
                          right: 10.0,
                          child: Text('Comment:'),
                        ),
                        Positioned(
                          top: 30.0,
                          left: 30.0,
                          right: 30.0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: 10,
                                  height: 90,
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
                                  flex: 5,
                                  child: Text(
                                    'Lecturer Name',
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left,
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 380.0,
                            left: 20.0,
                            right: 20.0,
                            child: FlatButton(
                              child: Text(
                                'UPLOAD VIDEO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: primaryColor,
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )),
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
