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
                      fontSize: MediaQuery.of(context).textScaleFactor * 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: MediaQuery.of(context).size.width * 0.175,
                alignment: Alignment.center,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      transaction.title,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      DateFormat.yMMMd().format(transaction.date),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize:
                              MediaQuery.of(context).textScaleFactor * 13),
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
                  size: MediaQuery.of(context).textScaleFactor * 25,
                ),
                onPressed: () {
                  deleteTransaction(transaction);
                },
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        elevation: 2,
      ),
    );
  }
}
