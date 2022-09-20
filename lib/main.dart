import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:intl/intl.dart';

import 'models/transaction_model.dart';
import 'widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    title: 'Personal Expenses',
    theme: ThemeData(
      primarySwatch: Colors.pink,
      accentColor: Colors.white,
      fontFamily: 'Quicksand',
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textTheme: ButtonTextTheme.accent,
      ),
    ),
    home: Transactions(),
  ));
}

class Transactions extends StatefulWidget {
  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Transaction> _transactions = [
    Transaction(id: 't1', amount: 10, title: 'Shoes', date: DateTime.now()),
    Transaction(id: 't1', amount: 20, title: 'Shoes', date: DateTime.now()),
    Transaction(
        id: 't1',
        amount: 40,
        title: 'Shoes',
        date: new DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse('2022-06-24 15:52:32.733690')),
    Transaction(
        id: 't1',
        amount: 60,
        title: 'Shoes',
        date: new DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse('2022-06-26 15:52:32.733690')),
    Transaction(
        id: 't1',
        amount: 15,
        title: 'Shoes',
        date: new DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse('2022-06-23 15:52:32.733690')),
    Transaction(id: 't2', amount: 50, title: 'Shirt', date: DateTime.now()),
  ];

  void _addTrxToList(String title, double amount, DateTime date) {
    var newTrx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        date: date);
    setState(() {
      _transactions.add(newTrx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: Colors.blueGrey.shade50,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: null,
            child: NewTransaction(_addTrxToList),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    print(isLandscape.toString());
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text('Transactions'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ExpenseChart(_transactions),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.8,
                child: TransactionList(transactionList: _transactions),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
