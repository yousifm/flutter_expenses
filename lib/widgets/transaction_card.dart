import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  static NumberFormat formater =
      NumberFormat.compactCurrency(symbol: "\$", decimalDigits: 2);

  const TransactionCard(this.transaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            Row(children: [
              Container(
                child: Text(
                  formater.format(transaction.amount),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: 75,
                alignment: Alignment.center,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      DateFormat.yMMMd().format(transaction.date),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        start: BorderSide(width: 1, color: Colors.grey))),
              )
            ]),
            Container(
              child: FlatButton(
                child: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).primaryColorDark,
                  size: 30,
                ),
                onPressed: () {
                  deleteTransaction(transaction);
                },
              ),
              width: 75,
              height: 75,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        elevation: 2,
      ),
    );
  }
}
