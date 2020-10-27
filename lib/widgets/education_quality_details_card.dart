import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarccaring_app/widgets/size_config.dart';

class EducationQualityDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: SizedBox(),),
          Container(
            height: SizeConfig.blockSizeVertical * 15,
            width: SizeConfig.blockSizeVertical * 10,
            child: SvgPicture.asset(
              'assets/images/svg/educationquality.svg',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(flex: 1, child: SizedBox(),),
          Text("Education Quality Feedback"),
          Expanded(flex: 1, child: SizedBox(),),
        ],
      ),
    );
  }
}
