import 'package:flutter/material.dart';

class ExpandingBar extends StatefulWidget {
  final double width;
  final double height;
  ExpandingBar(this.width, this.height);

  _ExpandingbarState createState() => _ExpandingbarState();
}

class _ExpandingbarState extends State<ExpandingBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: 75,
        width: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(5), bottom: Radius.circular(5)),
          color: Theme.of(context).primaryColorLight,
        ),
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutQuad);
  }
}
