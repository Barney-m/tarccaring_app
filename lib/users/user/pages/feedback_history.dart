import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/campus_facilities_card.dart';
import 'package:tarccaring_app/widgets/canteen_food_card.dart';
import 'package:tarccaring_app/widgets/education_quality_card.dart';
import 'package:tarccaring_app/widgets/service_attitude_card.dart';
import 'package:tarccaring_app/widgets/search_box.dart';

class FeedbackHistory extends StatefulWidget {
  @override
  _FeedbackHistory createState() => _FeedbackHistory();
}

class _FeedbackHistory extends State<FeedbackHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                ListView(
                  children: <Widget>[
                    CampusFacilitiesCard(itemIndex: 1),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
