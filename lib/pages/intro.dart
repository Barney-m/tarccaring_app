import 'package:flutter/material.dart';
import 'package:tarccaring_app/router/constant_route.dart';
import 'package:tarccaring_app/shared_prefs.dart';
import 'package:tarccaring_app/utils/constants.dart';
import 'package:tarccaring_app/widgets/page_stepper.dart';
import 'package:tarccaring_app/widgets/page_template.dart';

class Intro extends StatefulWidget {
  State<Intro> createState() {
    return _IntroPages();
  }
}

class _IntroPages extends State<Intro> {
  final PageController controller = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: PageView(
                controller: controller,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: <Widget>[
                  PageTemplate(
                    image: "assets/images/svg/idea.svg",
                    width: 200.0,
                  ),
                  PageTemplate(
                    image: "assets/images/svg/social media.svg",
                    width: 300.0,
                  ),
                  PageTemplate(
                    image: "assets/images/svg/solving.svg",
                    width: 250.0,
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    onTap: () {
                      setFirstTimeState().then((res) {
                        Navigator.of(context)
                            .pushReplacementNamed(AuthMainRoute);
                      });
                    },
                  ),
                  PageStepper(
                      currentStep: _currentPage + 1, controller: controller),
                  GestureDetector(
                    onTap: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 3),
                          curve: Curves.ease);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: secondaryColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
