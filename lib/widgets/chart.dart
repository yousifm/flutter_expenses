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

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (maxValue, item) {
      return (item['amount'] as double) > maxValue ? item['amount'] : maxValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Row(
                children: groupedTransactionValues.map((data) {
                  return ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendingPct: maxSpending > 0
                        ? (data['amount'] as double) / maxSpending
                        : 0,
                  );
                }).toList(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )),
          Text(
            "Total Spending: ${NumberFormat.compactCurrency(symbol: '\$').format(totalSpending)}",
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).textScaleFactor * 14),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      elevation: 6,
      color: Theme.of(context).primaryColorDark,
    );
  }
}
