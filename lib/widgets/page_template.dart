import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageTemplate extends StatelessWidget {
  final String image;
  final double width;

  PageTemplate({@required this.image, @required this.width})
      : assert(image != null, width != null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  image,
                  width: width,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "The Grateful Feedback Application",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
                Text(
                  "Aim to get a better campus life and experience!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
