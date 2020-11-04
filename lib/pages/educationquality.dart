import 'package:flutter/material.dart';
import 'package:tarccaring_app/pages/lecturerlist.dart';
import 'package:tarccaring_app/users/user/pages/feedback_history.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:tarccaring_app/widgets/size_config.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationQuality extends StatefulWidget {
  EducationQuality({this.lecturer_id, this.name, this.image,});
  final String lecturer_id;
  final String name;
  final String image;
  @override
  State<StatefulWidget> createState() { return new _EducationQuality();}
}

class _EducationQuality extends State<EducationQuality> {
  String _user;
  //final bool autocorrect;

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
  Future<void> _submit(BuildContext context) async{
    if(_comment.text.toString().trim() != null){
      var data = {
        'user_id' : _user,
        'lecturer_id' : widget.lecturer_id,
        'anonymous' : isSwitched,
        'comment' : _comment.text.toString(),
        'feedback_type' : 3,
      };
      var result = await APIService().postMethod(data,'submit');
      var message = json.decode(result.body);
      if(message['success'] == true){
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext  context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              title: Text("Submit Successful!",
                        style: new TextStyle(
                                fontSize: 20.0,
                              ),
                        ),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: SimpleDialogOption(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(UserNavigationRoute);
                    },
                    child: const Text('OK',style: TextStyle(color: Colors.black),
                  ),
                ),
                ),
              ],
            );
          },
        );
      } else{
        showDialog(
          context: context,
          builder: (BuildContext  context) {
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
    } else{
      showDialog(
        context: context,
        builder: (BuildContext  context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            contentTextStyle: TextStyle(color: Colors.black, fontSize: 18),
            title: Text("Invalid Action."),
            content: Text("Please fill the comment."),
          );
        },
      );
    }
  }

  @override
  void dispose(){
    _comment.dispose();
    super.dispose();
  }

  bool isSwitched = false;
  final _comment = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    String todo = ModalRoute.of(context).settings.arguments;

    SizeConfig().init(context);

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
                              defaultPadding / 2, SizeConfig.blockSizeVertical * 19, defaultPadding / 2, 0),
                          //margin: EdgeInsets.all(defaultPadding / 2),
                          child: Column(children: <Widget>[
                            Expanded(
                              child: TextField(
                                autocorrect: true,
                                controller: _comment,
                                keyboardType: TextInputType.multiline,
                                maxLines: 12,
                                style: TextStyle(fontSize: 15),
                                decoration: new InputDecoration(
                                    hintText: "Type your comment here....",
                                    hintStyle: TextStyle(fontSize: 15),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
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
                          top: SizeConfig.blockSizeVertical * 1.2,
                          left: SizeConfig.blockSizeVertical * 3,
                          right: SizeConfig.blockSizeVertical * 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context)
                                          .pushReplacementNamed(LecturerListRoute),
                                  child: Container(
                                    width: SizeConfig.blockSizeVertical * 1,
                                    height: SizeConfig.blockSizeVertical * 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                            'http://10.0.2.2:8000/images/user/'+ widget.image),
                                      ),
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
                                    widget.name,
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
                          top: SizeConfig.blockSizeVertical * 15.5,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: Text('Comment:'),
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
                              return showDialog(
                                context: context,
                                barrierDismissible: false,
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
                                            'Lecturer:',
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '    ' + widget.lecturer_id,
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
                                                    CanteenFoodRoute);
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
