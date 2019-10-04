import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatefulWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;
  ChartBar({
    this.label,
    this.spendingAmount,
    this.spendingPct,
  });

  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar>
    with SingleTickerProviderStateMixin {
  double maxHeight;
  double _height;

  var animValues = {
    'width': 25.0,
    'duration': Duration(seconds: 1),
    'curve': Curves.easeInOutQuad
  };

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height * 0.2;
    animValues['width'] = MediaQuery.of(context).size.width * 0.08;

    setState(() {
      _height = maxHeight * widget.spendingPct;
    });

    NumberFormat formatter =
        NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 0);

    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(children: [
        Text(formatter.format(widget.spendingAmount),
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).textScaleFactor * 15)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Container(
          child: Column(
            children: [
              AnimatedContainer(
                height: maxHeight - _height,
                width: animValues['width'],
                duration: animValues['duration'],
                curve: animValues['curve'],
              ),
              AnimatedContainer(
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(5), bottom: Radius.circular(5)),
                  color: Theme.of(context).primaryColorLight,
                ),
                width: animValues['width'],
                duration: animValues['duration'],
                curve: animValues['curve'],
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Text(
          widget.label,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).textScaleFactor * 15),
        )
      ]);
    });
  }
}
