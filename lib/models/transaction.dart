import 'package:flutter/foundation.dart';

class Transaction {
  String title;
  double amount;
  DateTime date;

  Transaction(
      {@required this.title, @required this.amount, @required this.date});
}
