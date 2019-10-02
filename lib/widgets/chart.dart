import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: 6 - index));
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
              child: Flex(
                children: groupedTransactionValues.map((data) {
                  return ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendingPct: totalSpending > 0
                        ? (data['amount'] as double) / totalSpending
                        : 0,
                  );
                }).toList(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                direction: Axis.horizontal,
              ),
            ),
            Text(
              "Total Spending: ${NumberFormat.compactCurrency(symbol: '\$').format(totalSpending)}",
              style: TextStyle(color: Colors.white),
            ),
          ]),
        ),
        elevation: 6,
        color: Theme.of(context).primaryColorDark,
      ),
      width: double.infinity,
    );
  }
}
