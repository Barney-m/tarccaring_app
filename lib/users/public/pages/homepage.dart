import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/campus_facilities_card.dart';
import 'package:tarccaring_app/widgets/canteen_food_card.dart';
import 'package:tarccaring_app/widgets/service_attitude_card.dart';

class Homepage extends StatefulWidget {
  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: defaultPadding),
            child: Text(
              'Welcome',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                    CanteenFoodCard(itemIndex: 2),
                    ServiceAttitudeCard(itemIndex: 3),
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
