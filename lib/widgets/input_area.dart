import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:expenses/models/transaction.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class InputArea extends StatefulWidget {
  final Function buttonPressCallback;

  InputArea(this.buttonPressCallback);
  @override
  State<StatefulWidget> createState() {
    return _InputAreaState(buttonPressCallback);
  }
}

class _InputAreaState extends State<StatefulWidget> {
  final titleController = TextEditingController();
  final amountController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  static DateTime today = DateTime.now();
  DateTime date = DateTime.now();

  Function buttonPressCallback;

  _InputAreaState(this.buttonPressCallback);

  void onButtonPress() {
    print(amountController.numberValue);
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        amountController.numberValue <= 0) {
      return;
    }

    Transaction newT = Transaction(
        title: titleController.text,
        amount: amountController.numberValue,
        date: date);

    titleController.clear();
    amountController.clear();
    setState(() {
      date = DateTime.now();
    });
    buttonPressCallback(newT);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: OutlineButton(
                child: Text(
                  "Date: ${DateFormat.yMMMMd().format(date)}",
                ),
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 1),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        date = pickedDate;
                      });
                    }
                  });
                },
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text("Add Transaction"),
                  onPressed: onButtonPress,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ))
          ],
        ),
      ),
      elevation: 2,
    );
  }
}
