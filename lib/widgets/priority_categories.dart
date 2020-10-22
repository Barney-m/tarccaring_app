import 'package:flutter/material.dart';
import 'package:tarccaring_app/utils/constants.dart';

class PriorityCategories extends StatefulWidget {
  @override
  _PriorityCategories createState() => _PriorityCategories();
}

class _PriorityCategories extends State<PriorityCategories> {
  int _selectedIndex = 0;
  List categories = ['1', '2', '3', '4', '5'];

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
