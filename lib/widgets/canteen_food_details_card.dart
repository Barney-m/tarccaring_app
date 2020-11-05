import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarccaring_app/widgets/size_config.dart';

class CanteenFeedbackDetailsCard extends StatelessWidget {
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
              'assets/images/svg/canteenfood.svg',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(flex: 1, child: SizedBox(),),
          Text("Campus Facility Feedback"),
          Expanded(flex: 1, child: SizedBox(),),
        ],
      ),
    );
  }
}
