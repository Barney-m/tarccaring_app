import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/api.dart';
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
  int _selectedIndex = 0;
  List categories = ['All', 'FOCS', 'FAFB', 'FBCC', 'FEFC'];


  Future<List<dynamic>> fetchFeedbacks() async {
      var result = await APIService().getMethod('lecturer?faculty=' + categories[_selectedIndex].toString());
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
                        if (snapshot.hasData) {//TODO: Show Status
                          return ListView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  child: Column(children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                            radius:30,
                                            backgroundImage: NetworkImage('http://10.0.2.2:8000/images/user/' + snapshot.data[index]['image']),
                                          ),
                                  title: Text(snapshot.data[index]['name']),
                                  subtitle:Text(snapshot.data[index]['email']),
                                  isThreeLine: true,
                                  trailing: Text(snapshot.data[index]['gender'].toString().toUpperCase()),
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
