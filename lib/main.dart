import "package:flutter/material.dart";

import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/input_area.dart';
import 'package:expenses/widgets/transaction_list.dart';

import "package:expenses/models/transaction.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
            headline: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 15, fontFamily: 'Hind')),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void onSubmit(Transaction newT) {
    setState(() {
      transactions.add(newT);
      transactions.sort((a, b) => b.amount.compareTo(a.amount));
    });
  }

  void deleteTransaction(Transaction t) {
    setState(() {
      transactions.removeWhere((trans) => trans == t);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return InputArea(onSubmit);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Container(
        child: Column(
          children: [
            Chart(_recentTransactions),
            TransactionList(transactions, deleteTransaction)
          ],
        ),
        width: double.infinity,
        padding: EdgeInsets.all(5),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
