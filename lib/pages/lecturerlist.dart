import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tarccaring_app/widgets/search_box.dart';
import 'package:tarccaring_app/widgets/custom_dropdown.dart';
import 'package:tarccaring_app/widgets/size_config.dart';

class LecturerList extends StatefulWidget {
  @override
  _LecturerList createState() => _LecturerList();
}

class _LecturerList extends State {
  Future<List<dynamic>> fetchFeedbacks() async {
    var result = await http
        .get('https://randomuser.me/api/?results=10'); //TODO: Complete API
    return json.decode(result.body)['results'];
  }

  String _type(dynamic feedback) {
    return feedback['name']['title'] +
        " " +
        feedback['name']['first'] +
        " " +
        feedback['name']['last'];
  }

  String _content(dynamic feedback) {
    return feedback['location']['country'];
  }

  String _status(dynamic feedback) {
    return "Age: " + feedback['dob']['age'].toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Lecturer List'),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SearchBox(onChanged: (value) {}),
            custom_dropdown(),
            SizedBox(height: defaultPadding / 2),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: FutureBuilder<List<dynamic>>(
                        future: fetchFeedbacks(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print(
                                _status(snapshot.data[0])); //TODO: Show Status
                            return ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    child: Column(children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          snapshot.data[index]['picture']
                                              ['large']), //TODO: Image
                                    ),
                                    title: Text(_type(snapshot.data[index])),
                                    //TODO: Feedback Type
                                    subtitle:
                                        Text(_content(snapshot.data[index])),
                                    isThreeLine: true,
                                    trailing: Text(_status(
                                        snapshot.data[index])), //TODO: status
                                  )
                                ]));
                              },
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
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
