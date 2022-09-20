import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTrx;

  NewTransaction(this.newTrx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final title = titleController.text;
    final amount = amountController.text;

    if (title.isEmpty ||
        amount.isEmpty ||
        double.parse(amount) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.newTrx(titleController.text, double.parse(amountController.text),
        _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 42)),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0), bottom: Radius.circular(20.0))),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Title1'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Title2'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Title3'),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date chosen!'
                        : 'Selected Date : ${DateFormat.yMMMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: _showDatePicker,
                    child: Text('Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 3, 5, 0),
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Add Transaction'),
                    onPressed: () {
                      _submitData();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
