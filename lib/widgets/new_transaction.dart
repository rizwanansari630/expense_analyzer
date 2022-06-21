import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTrx;

  NewTransaction(this.newTrx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final title = titleController.text;
    final amount = amountController.text;

    if(title.isEmpty || amount.isEmpty || double.parse(amount) <= 0){
      return;
    }
    widget.newTrx(
      titleController.text,
      double.parse(amountController.text),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            onSubmitted: (_) => submitData(),
            keyboardType: TextInputType.number,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 3, 5, 0),
            child: RaisedButton(
                child: Text('Add Transaction'),
                onPressed: () {
                  submitData();
                  print(titleController.text);
                  print(amountController.text);
                }),
          )
        ],
      ),
    );
  }
}
