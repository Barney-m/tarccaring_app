import 'dart:convert';
import 'package:tarccaring_app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/campus_feedback_details_card.dart';
import 'package:tarccaring_app/widgets/canteen_food_details_card.dart';
import 'package:tarccaring_app/widgets/service_attitude_details_card.dart';
import 'package:tarccaring_app/widgets/education_quality_details_card.dart';
import 'package:tarccaring_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagementFeedbackDetailPage extends StatefulWidget {
  ManagementFeedbackDetailPage({
    this.id,
    this.creator,
    this.name,
    this.comment,
    this.type,
    this.attachment,
    this.choice,
    this.status,
    this.pendingDate,
  });

  final int id;
  final String creator;
  final String name;
  final String comment;
  final String type;
  final String attachment;
  final String choice;
  final String status;
  final String pendingDate;

  //final String date;
  @override
  State<StatefulWidget> createState() {
    return new _ManagementFeedbackDetailPage();
  }
}

class _ManagementFeedbackDetailPage
    extends State<ManagementFeedbackDetailPage> {

  String _user;

  @override
  void initState() {
    super.initState();
    getID();
  }

  getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = prefs.getString('id') ?? '';
    });
  }

  @override
  String todo = '';

  int id;

  Future<void> _action(BuildContext context, String action) async {
    print(_user);
    var data = {
      'id': widget.id.toInt(),
      'user_id' : _user,
      'action': action,
    };
    var result = await APIService().postMethod(data, 'manage/action');
    var message = json.decode(result.body);

    if (message['message'] != null && message['success'] == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(20))),
            titleTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            title: Text(
              message['message'],
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacementNamed(ManagementNavigationRoute);
                    },
                    child: const Text('OK',style: TextStyle(color: Colors.white),)),
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
            title: Text("Failed!"),
            content: Text("Something went wrong...."),
          );
        },
      );
    }
  }

  Color statusColor(String status) {
    if (status == 'APPROVED') {
      return Colors.green;
    } else if (status == 'DISMISSED') {
      return Colors.red;
    } else if (status == 'URGENT') {
      return Colors.green[700];
    } else {
      return Colors.grey;
    }
  }

  _attachments() {
    switch (widget.type) {
      case 'Service Attitude Feedback':
        return Row(
          children: <Widget>[
            Text('Service Type: ' + widget.choice),
            Expanded(
              flex: 7,
              child: SizedBox(),
            ),
          ],
        );
        break;
      case 'Education Quality Feedback':
        return Row(
          children: <Widget>[
            Text('Lecturer: ' + widget.choice),
            Expanded(
              flex: 7,
              child: SizedBox(),
            ),
          ],
        );
        break;
      default:
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Text('Locations: ' + widget.choice),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Text('Attachment: '),
                ],
              ),
            ),
          ],
        );
    }
  }

  _actionButton() {
    switch (widget.status.toUpperCase()) {
      case 'PENDING':
        return Column(children: [
          ButtonTheme(
            minWidth: SizeConfig.blockSizeVertical * 60,
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
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                      title: Text(
                        'Confirmation',
                        textAlign: TextAlign.center,
                      ),
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'Are You Sure to Dismiss?',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(Once make decision cannot been change)',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height:
                              SizeConfig.blockSizeVertical *
                                  2,
                            ),
                            FlatButton(
                                child: Text(
                                  "CONFIRM",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                ),
                                onPressed: () {
                                  _action(context, 'dismiss');
                                }),
                            FlatButton(
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                        ManagementFeedbackDetailPage);
                                })
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ),
          ButtonTheme(
            minWidth: SizeConfig.blockSizeVertical * 60,
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
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                      title: Text(
                        'Confirmation',
                        textAlign: TextAlign.center,
                      ),
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'Are You Sure to Approve?',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(Once make decision cannot been change)',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height:
                              SizeConfig.blockSizeVertical *
                                  2,
                            ),
                            FlatButton(
                                child: Text(
                                  "CONFIRM",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                ),
                                onPressed: () {
                                  _action(context, 'approve');
                                }),
                            FlatButton(
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      ManagementFeedbackDetailPage);
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
          ButtonTheme(
            minWidth: SizeConfig.blockSizeVertical * 60,
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
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                      title: Text(
                        'Confirmation',
                        textAlign: TextAlign.center,
                      ),
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'Are You Sure to Set Urgent?',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(Once make decision cannot been change)',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height:
                              SizeConfig.blockSizeVertical *
                                  2,
                            ),
                            FlatButton(
                                child: Text(
                                  "CONFIRM",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                ),
                                onPressed: () {
                                  _action(context, 'urgent');
                                }),
                            FlatButton(
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      ManagementFeedbackDetailPage);
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
        ]);
        break;
      case 'DISMISSED':
        return Container(
          child: SizedBox(),
        );
        break;
      default:
        return Column(children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          ButtonTheme(
            minWidth: SizeConfig.blockSizeVertical * 60,
            child: FlatButton(
                child: Text(
                  'SOLVED',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.blue[300],
                onPressed: () {
                  return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        title: Text(
                          'Confirmation',
                          textAlign: TextAlign.center,
                        ),
                        titleTextStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                'Are You Sure Solved?',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '(Once make decision cannot been change)',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                SizeConfig.blockSizeVertical *
                                    2,
                              ),
                              FlatButton(
                                  child: Text(
                                    "CONFIRM",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 16.0,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(6.0),
                                  ),
                                  onPressed: () {
                                    _action(context, 'solve');
                                  }),
                              FlatButton(
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 16.0,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(6.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context,
                                        ManagementNavigationRoute);
                                  })
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
            ),
          ),
        ]);

    }
  }

  _cardType() {
    switch (widget.type) {
      case 'Campus Facility Feedback':
        return CampusFeedbackDetailsCard();
        break;
      case 'Canteen Food Feedback':
        return CanteenFeedbackDetailsCard();
        break;
      case 'Service Attitude Feedback':
        return ServiceAttitudeDetailsCard();
        break;
      case 'Education Quality Feedback':
        return EducationQualityDetailsCard();
        break;
    }
  }

  Widget build(BuildContext context) {
    todo = ModalRoute.of(context).settings.arguments;
    //todo = ModalRoute.of(context).settings.arguments;

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
                    margin:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 19),
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
                      title: Text(''),
                      // You can add title here
                      leading: new IconButton(
                        icon:
                            new Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      backgroundColor: primaryColor.withOpacity(0.3),
                      //You can make this transparent
                      elevation: 0.0, //No shadow
                    ),
                  ),
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
                                widget.name,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                widget.name,
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
                        defaultPadding * 1.5,
                        SizeConfig.blockSizeVertical * 13,
                        defaultPadding * 1.5,
                        0),
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
                              defaultPadding / 2,
                              SizeConfig.blockSizeVertical * 5,
                              defaultPadding / 2,
                              0),
                          height: SizeConfig.blockSizeVertical * 42,
                          child: Column(children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    widget.status.toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor(widget.status
                                          .toString()
                                          .toUpperCase()),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(),
                                  ),
                                  Text(
                                    widget.pendingDate.toString(),
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  //Text(widget.date),
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
                              flex: 1,
                              child: Container(
                                width: SizeConfig.blockSizeVertical * 300,
                                padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeVertical * 2,
                                  top: SizeConfig.blockSizeVertical * 1,
                                  left: SizeConfig.blockSizeVertical * 2,
                                  bottom: SizeConfig.blockSizeVertical * 1,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical, //.horizontal
                                  child: new Text(
                                    widget.comment,
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: _attachments())
                          ]),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 50,
                          left: SizeConfig.blockSizeVertical * 10,
                          right: SizeConfig.blockSizeVertical * 10,
                          child: InkWell(
                            onTap: () =>
                             showDialog(
                              context: context,
                              builder: (BuildContext  context) {
                                return AlertDialog(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  content: Container(
                                    width: SizeConfig.blockSizeVertical * 30,
                                    height: SizeConfig.blockSizeVertical * 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                            'http://192.168.43.203:8000/images/image_attachment/' +
                                                widget.attachment
                                          //"https://i.pinimg.com/originals/45/e6/49/45e64948063fcee9fed27800800e47ca.jpg"
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            child: Container(
                              width: SizeConfig.blockSizeVertical * 1,
                              height: SizeConfig.blockSizeVertical * 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  fit: BoxFit.contain,
                                  image: new NetworkImage(
                                      'http://192.168.43.203:8000/images/image_attachment/' +
                                          widget.attachment
                                    //"https://i.pinimg.com/originals/45/e6/49/45e64948063fcee9fed27800800e47ca.jpg"
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 64,
                          left: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeVertical * 2,
                          child: _actionButton(),
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
