import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tarccaring_app/widgets/size_config.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampusFacilities extends StatefulWidget {
  @override
  _CampusFacilities createState() => _CampusFacilities();
}

class _CampusFacilities extends State<CampusFacilities> with TickerProviderStateMixin{
  String _user;
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
  void initState() {
    super.initState();
    getID();
  }

  getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = prefs.getString('id') ?? null;
    });
  }

  Future<void> _submit(BuildContext context) async {
    if (_comment.text.toString().trim() != '' && selectLocation != '') {
      var data = {};
      if (_image != null) {
        List<int> imageBytes = _image.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        data = {
          'user_id': _user,
          'action': selectLocation,
          'anonymous': isSwitched,
          'comment': _comment.text.toString(),
          'attachment': base64Image,
          'feedback_type': 1,
        };
      } else {
        data = {
          'user_id': _user,
          'action': selectLocation,
          'anonymous': isSwitched,
          'comment': _comment.text.toString(),
          'feedback_type': 1,
        };
      }
      var result = await APIService().postMethod(data, 'submit');
      var message = json.decode(result.body);
      if (message['success'] == true) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              title: Text(
                "Submit Successful!",
                style: new TextStyle(
                  fontSize: 20.0,
                ),
              ),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(
                            context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              contentTextStyle: TextStyle(color: Colors.black, fontSize: 18),
              title: Text("Submit Failed!"),
              content: Text("Something went wrong...."),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            contentTextStyle: TextStyle(color: Colors.black, fontSize: 18),
            title: Text("Invalid Action."),
            content: Text("Please fill up the form."),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }
  
  anonymous(bool isSwitched) {
    if (isSwitched == false) {
      return Text(
        '    $_user',
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      );
    } else if (isSwitched == true) {
      return Text(
        '    ' + 'ANONYMOUSLY',
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      );
    }
  }

  final _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Campus Facilities'),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
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
                        defaultPadding * 1.5,
                        SizeConfig.blockSizeVertical * 6,
                        defaultPadding * 1.5,
                        0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultPadding / 2,
                              SizeConfig.blockSizeVertical * 19,
                              defaultPadding / 2,
                              0),
                          //margin: EdgeInsets.all(defaultPadding / 2),
                          child: Column(children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _comment,
                                keyboardType: TextInputType.multiline,
                                maxLines: 7,
                                style: TextStyle(fontSize: 15),
                                decoration: new InputDecoration(
                                    hintText: "Type your comment here....",
                                    hintStyle: TextStyle(fontSize: 15),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
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
                            controller: locationSelected,
                            hintText: "Locations",
                            enabled: true,
                            items: locations,
                            onValueChanged: (value) {
                              setState(() {
                                selectLocation = value;
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
                          top: SizeConfig.blockSizeVertical * 43,
                          left: SizeConfig.blockSizeVertical * 5,
                          right: SizeConfig.blockSizeVertical * 5,
                          child: _image == null
                              ? Container(
                                  height: SizeConfig.blockSizeVertical * 15,
                                  width: SizeConfig.blockSizeVertical * 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                  ),
                                )
                              : Image.file(
                                  _image,
                                  height: SizeConfig.blockSizeVertical * 15,
                                  width: SizeConfig.blockSizeVertical * 15,
                                ),
                        ),
                        Positioned(
                            top: SizeConfig.blockSizeVertical * 60,
                            left: SizeConfig.blockSizeVertical * 4,
                            right: SizeConfig.blockSizeVertical * 8,
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
                          top: SizeConfig.blockSizeVertical * 60,
                          left: SizeConfig.blockSizeVertical * 35,
                          right: SizeConfig.blockSizeVertical * 3,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              getImage(true);
                            },
                          ),
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
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    title: Text(
                                      'Feedback Confirmation',
                                      textAlign: TextAlign.center,
                                    ),
                                    titleTextStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'By:',
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          anonymous(isSwitched),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    2,
                                          ),
                                          Text(
                                            'Location:',
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '    ' + selectLocation,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    2,
                                          ),
                                          Text(
                                            'Comment:',
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '    ' + _comment.text,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    4,
                                          ),
                                          Text(
                                            'ATTACHMENT:',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          _image == null
                                              ? Container(
                                            height: SizeConfig.blockSizeVertical * 15,
                                            width: SizeConfig.blockSizeVertical * 5,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                          )
                                              : Image.file(
                                            _image,
                                            height: SizeConfig.blockSizeVertical * 15,
                                            width: SizeConfig.blockSizeVertical * 15,
                                          ),
                                          SizedBox(
                                            height:
                                            SizeConfig.blockSizeVertical *
                                                4,
                                          ),
                                          FlatButton(
                                              child: Text(
                                                "CONFIRM",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              color: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                              onPressed: () {
                                                _submit(context);
                                              }),
                                          FlatButton(
                                              child: Text(
                                                "DISCARD",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              color: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context,
                                                    CampusFacilitiesRoute);
                                              })
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
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

final locationSelected = TextEditingController();
String selectLocation = "";

List<String> locations = [
  "BLOCK H",
  "BLOCK K",
  "BLOCK A",
  "BLOCK M",
  "BLOCK Q",
  "BLOCK R",
  "LIBRARY",
  "RED BRICK CANTEEN",
  "YUM YUM CAFE",
  "CITC",
  "BANGUNAN TSTT",
  "CANTEEN 3",
  "BASKETBALL COURT",
  "DK A",
  "DK ABA",
  "EAST CAMPUS"
];
