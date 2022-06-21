import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';

import 'models/transaction_model.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(MaterialApp(
    title: 'Personal Expenses',
    theme: ThemeData(
      primarySwatch: Colors.pink,
      accentColor: Colors.green,
      fontFamily: 'Quicksand',
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
  //   Transaction(id: 't1', amount: 2000, title: 'Shoes', date: DateTime.now()),
  //   Transaction(id: 't2', amount: 100, title: 'Shirt', date: DateTime.now()),
  ];

  void _addTrxToList(String title, double amount) {
    var newTrx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        date: DateTime.now());
    setState(() {
      _transactions.add(newTrx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Transactions'),
          actions: [
            IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                child: Card(
                  child: Text('Card1'),
                ),
              ),
              TransactionList(transactionList: _transactions),
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
