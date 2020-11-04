import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tarccaring_app/utils/api.dart';
import 'dart:convert';
import 'package:tarccaring_app/widgets/search_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'management_feedback_detail.dart';

class ManagementHistory extends StatefulWidget {
  @override
  _ManagementHistory createState() => _ManagementHistory();
}

class _ManagementHistory extends State<ManagementHistory> {
  int _selectedIndex = 0;
  List categories = ['All', 'Facilities', 'Foods', 'Educations', 'Services'];

  String _user;

  @override
  void initState() {
    super.initState();
    getID();
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

  getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = prefs.getString('id') ?? '';
    });
  }

  Future<List<dynamic>> fetchFeedbacks() async {
    var result = await APIService().getMethod('feedbacks/history?type=' + _selectedIndex.toString() + '&id=$_user');
    return json.decode(result.body);
  }

  final _type = [
    Icons.home,
    Icons.home,
    Icons.home,
    Icons.home,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          // SearchBox(onChanged: (value) {}),
          Container(
            margin: EdgeInsets.symmetric(vertical: defaultPadding / 2),
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  fetchFeedbacks();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: defaultPadding,
                    right: index == categories.length - 1
                        ? defaultPadding
                        : 0, // Add extra padding when reach last item
                  ),
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  decoration: BoxDecoration(
                    color: index == _selectedIndex
                        ? Colors.white.withOpacity(0.4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
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
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  child: Column(children: <Widget>[
                                ListTile(
                                  leading: Icon(_type[snapshot.data[index]['feedbackType_id'] - 1], size: 40.0),
                                  title: Text(snapshot.data[index]['type']),
                                  subtitle:Text(snapshot.data[index]['comment']),
                                  isThreeLine: true,
                                  trailing: Text(snapshot.data[index]['status'].toString().toUpperCase(),style: TextStyle(color: statusColor(snapshot
                                      .data[index]['status']
                                      .toString()
                                      .toUpperCase()),),),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        new ManagementFeedbackDetailPage(
                                          id: snapshot.data[index]['id'],
                                          creator: snapshot.data[index]['creator_id'].toString(),
                                          comment: snapshot.data[index]['comment'],
                                          type: snapshot.data[index]['type'],
                                          attachment: snapshot.data[index]['attachment'].toString(),
                                          anonymous: snapshot.data[index]['anonymous'] == 0 ? false : true,
                                          status: snapshot.data[index]['status'],
                                          pendingDate: snapshot.data[index]['created_at'].toString(),
                                          choice: snapshot.data[index]['choice'].toString(),
                                        ),
                                      ),
                                    );
                                  },
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
    );
  }
}
