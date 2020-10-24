import 'package:flutter/material.dart';
import 'package:tarccaring_app/shared_prefs.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/campus_facilities_card.dart';
import 'package:tarccaring_app/widgets/canteen_food_card.dart';
import 'package:tarccaring_app/widgets/education_quality_card.dart';
import 'package:tarccaring_app/widgets/service_attitude_card.dart';
import 'package:tarccaring_app/widgets/search_box.dart';

class Homepage extends StatefulWidget {
  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  String _id;

  @override
  void initState() {
    super.initState();
    getUserID();
  }
  
  Future<void> getUserID() async{
    _id = await getID();
    print(_id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: defaultPadding),
            child: Text(
              'Welcome, $_id',
              style: TextStyle(
                fontSize: 30,
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
                    EducationQualityCard(itemIndex: 3),
                    ServiceAttitudeCard(itemIndex: 4),
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
