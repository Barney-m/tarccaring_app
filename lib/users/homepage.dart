import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/homepage_card.dart';
import 'package:tarccaring_app/widgets/search_box.dart';
import 'package:tarccaring_app/model/feedback_types.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('Homepage'),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            SearchBox(onChanged: (value) {}),
            SizedBox(height: defaultPadding / 2),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  HomepageCard(itemIndex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
