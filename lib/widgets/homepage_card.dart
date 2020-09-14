import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';

class HomepageCard extends StatelessWidget {
  const HomepageCard({
    Key key,
    this.itemIndex,
  }) : super(key: key);

  final int itemIndex;

  int indexIncrement() => this.itemIndex + 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        //Campus Facilities
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          height: 160,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(CampusFacilitiesRoute),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 136,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: itemIndex.isEven ? secondaryColor : thirdColor,
                    boxShadow: [defaultShadow],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Hero(
                    tag: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      height: 160,
                      width: 200,
                      child: Image.asset(
                        'campusfacilities.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    height: 136,
                    width: size.width - 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Text(
                            'Campus Facilities Feedback',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding / 4,
                          ),
                          decoration: BoxDecoration(
                            color: thirdColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Campus Facilities
        //Canteen Food
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          height: 160,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(CanteenFoodRoute),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 136,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: itemIndex.isEven ? secondaryColor : thirdColor,
                    boxShadow: [defaultShadow],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Hero(
                    tag: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      height: 160,
                      width: 200,
                      child: Image.asset(
                        'canteenfood.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    height: 136,
                    width: size.width - 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Text(
                            'Canteen Food Feedback',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding / 4,
                          ),
                          decoration: BoxDecoration(
                            color: thirdColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Canteen Food
        //Education Quality
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          height: 160,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(EducationQualityRoute),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 136,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: itemIndex.isEven ? secondaryColor : thirdColor,
                    boxShadow: [defaultShadow],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Hero(
                    tag: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      height: 160,
                      width: 200,
                      child: Image.asset(
                        'educationquality.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    height: 136,
                    width: size.width - 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Text(
                            'Education Quality Feedback',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding / 4,
                          ),
                          decoration: BoxDecoration(
                            color: thirdColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Education Qaulity
        //Service Attitude
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          height: 160,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(ServiceAttitudeRoute),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 136,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: itemIndex.isEven ? secondaryColor : thirdColor,
                    boxShadow: [defaultShadow],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Hero(
                    tag: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      height: 160,
                      width: 200,
                      child: Image.asset(
                        'serviceattitude.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    height: 136,
                    width: size.width - 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Text(
                            'Service Attitude Feedback',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding / 4,
                          ),
                          decoration: BoxDecoration(
                            color: thirdColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //Service Attitude
      ],
    );
  }
}
