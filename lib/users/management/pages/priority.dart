import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tarccaring_app/utils/api.dart';
import 'dart:convert';
import 'package:tarccaring_app/widgets/search_box.dart';

import 'management_feedback_detail.dart';

class PriorityPage extends StatefulWidget {
  @override
  _PriorityPage createState() => _PriorityPage();
}

class _PriorityPage extends State<PriorityPage> {
  int _selectedIndex = 0;
  List categories = ['1', '2', '3', '4'];

  Future<List<dynamic>> fetchFeedbacks() async {
    switch (_selectedIndex) {
      case 1:
      case 2:
      case 3:
        var result = await APIService().getMethod('feedbacks?priority=' + categories[_selectedIndex].toString().toLowerCase());
        print (json.decode(result.body));
        return json.decode(result.body);
        break;
      default:
        var result = await APIService().getMethod('feedbacks?priority=1');
        print (json.decode(result.body));
        return json.decode(result.body);
    }
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
          Container(
            margin: EdgeInsets.only(top: defaultPadding),
            child: Text(
              'Welcome, User',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                        if (snapshot.hasData) { //TODO: Show Status
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
                                  trailing: Text(snapshot.data[index]['status'].toString().toUpperCase()),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        new ManagementFeedbackDetailPage(
                                          name: snapshot.data[index]['creator_id'].toString(),
                                          comment: snapshot.data[index]['comment'],
                                          type: snapshot.data[index]['type'],
                                          attachment: snapshot.data[index]['attachment'].toString(),
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
