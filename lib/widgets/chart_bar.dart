import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatefulWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;
  final double maxHeight = 100;
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
  double _height;
  final animValues = {
    'width': 25.0,
    'duration': Duration(seconds: 1),
    'curve': Curves.easeInOutQuad
  };
  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = widget.maxHeight * widget.spendingPct;
    });

    NumberFormat formatter =
        NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 0);

    return Flexible(
      child: Column(children: [
        Text(
          formatter.format(widget.spendingAmount),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: [
            AnimatedContainer(
              height: widget.maxHeight - _height,
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
        SizedBox(
          height: 5,
        ),
        Text(
          widget.label,
          style: TextStyle(color: Colors.white),
        )
      ]),
      flex: 1,
    );
  }
}
