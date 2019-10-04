import 'package:flutter/material.dart';

import 'transaction_card.dart';
import 'package:expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: transactions.length + 1,
      itemBuilder: (BuildContext ctx, int index) {
        if (transactions.length == 0) {
          return Column(children: [
            Container(
              child: Text(
                "No transactions yet!",
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 20),
              ),
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.shortestSide * 0.05),
            ),
            Image.asset(
              "assets/images/waiting.png",
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.grey[300],
            )
          ]);
        }
        if (index == transactions.length)
          return SizedBox(
            height: 75,
          );
        return TransactionCard(transactions[index], deleteTransaction);
      },
      physics: BouncingScrollPhysics(),
    ));
  }
}
