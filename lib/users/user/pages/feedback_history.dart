import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarccaring_app/pages/feedbackdetailspage.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/utils/api.dart';
import 'dart:convert';

class FeedbackHistory extends StatefulWidget {
  @override
  _FeedbackHistory createState() => _FeedbackHistory();
}

class _FeedbackHistory extends State<FeedbackHistory> {
  int _selectedIndex = 0;
  List categories = ['All', 'Facilities', 'Foods', 'Educations', 'Services'];
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

  Future<List<dynamic>> fetchFeedbacks() async {
    switch (_selectedIndex) {
      case 1:
      case 2:
      case 3:
      case 4:
        var result = await APIService().getMethod(
            'feedbacks/user_history?id=$_user&feedback=' +
                _selectedIndex.toString());
        return json.decode(result.body);
        break;
      default:
        var result =
            await APIService().getMethod('feedbacks/user_history?id=$_user');
        return json.decode(result.body);
    }
  }

  Color statusColor(String status) {
    if (status == 'APPROVED') {
      return Colors.green;
    } else if (status == 'DISMISSED') {
      return Colors.red;
    } else if (status == 'SOLVED') {
      return Colors.lightGreen[700];
    } else if (status == 'URGENT') {
      return Colors.green[700];
    } else if(status == 'RECALLED'){
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  final _type = [
    Icons.event_seat_rounded,
    Icons.fastfood_rounded,
    Icons.menu_book_rounded,
    Icons.headset_mic_rounded,
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
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FeedbackDetailPage(
                                            id: snapshot.data[index]['id'],
                                            name: snapshot.data[index]['name'].toString(),
                                            image: snapshot.data[index]['image'].toString(),
                                            creator: snapshot.data[index]['creator_id'].toString(),
                                            comment: snapshot.data[index]['comment'],
                                            type: snapshot.data[index]['type'],
                                            attachment: snapshot.data[index]['attachment'].toString(),
                                            status: snapshot.data[index]['status'],
                                            pendingDate: snapshot.data[index]['created_at'].toString(),
                                            choice: snapshot.data[index]['choice'].toString(),
                                                //date: snapshot.data[index]['created_at']
                                          ),
                                        ),
                                      );
                                  },
                                  child: Card(
                                      child: Column(children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                          _type[snapshot.data[index]
                                                  ['feedbackType_id'] -
                                              1],
                                          size: 40.0),
                                      title: Text(snapshot.data[index]['type']),
                                      subtitle:
                                          Text(snapshot.data[index]['comment']),
                                      isThreeLine: true,
                                      trailing: Text(
                                        snapshot.data[index]['status']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: statusColor(snapshot
                                              .data[index]['status']
                                              .toString()
                                              .toUpperCase()),
                                        ),
                                      ),
                                    )
                                  ])));
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
