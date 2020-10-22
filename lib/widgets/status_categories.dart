import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';

class StatusCategories extends StatefulWidget {
  @override
  _StatusCategories createState() => _StatusCategories();
}

class _StatusCategories extends State<StatusCategories> {
  int _selectedIndex = 0;
  List categories = ['Approved', 'Urgent'];

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
