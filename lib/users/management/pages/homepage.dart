import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/api.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tarccaring_app/widgets/feedback_categories.dart';
import 'package:tarccaring_app/widgets/search_box.dart';

class ManagementHomepage extends StatefulWidget {
  @override
  _ManagementHomepage createState() => _ManagementHomepage();
}

class _ManagementHomepage extends State<ManagementHomepage> {
  Future<List<dynamic>> fetchFeedbacks() async {
    var result = await APIService().getMethod('feedbacks');
    print (json.decode(result.body));
    return json.decode(result.body);
  }

  String _type(dynamic feedback) {
    return '';
  }

  String _content(dynamic feedback) {
    return '';
  }

  String _status(dynamic feedback) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {}),
          FeedbackCategories(),
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
                                  title: Text(_type(snapshot.data[index])), //TODO: Feedback Type
                                  subtitle:Text(_content(snapshot.data[index])),
                                  isThreeLine: true,
                                  trailing: Text(_status(snapshot.data[index])), //TODO: status
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
