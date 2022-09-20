import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;

  TransactionList({@required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? Column(
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/waiting.png'),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    child: FittedBox(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 6),
                      child: Text('₹${transactionList[index].amount}'),
                    )),
                  ),
                  title: Text('${transactionList[index].title}'),
                  subtitle: Text(
                      DateFormat.yMMMMd().format(transactionList[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          textColor: Colors.red.shade700,
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                  onTap: () {
                    print(transactionList[index].amount);
                  },
                ),
                // child: Row(
                //   children: [
                //     Container(
                //       margin: EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //             color: Theme.of(context).primaryColor,
                //             width: 1,
                //             style: BorderStyle.solid),
                //       ),
                //       child: Text(
                //         '\₹${transactionList[index].amount.toStringAsFixed(2)}',
                //         style: TextStyle(
                //             color: Theme.of(context).primaryColorDark,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 14),
                //       ),
                //       padding: EdgeInsets.all(5),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           transactionList[index].title,
                //           style: Theme.of(context).textTheme.headline6,
                //         ),
                //         Text(
                //           DateFormat.yMMMd()
                //               .format(transactionList[index].date),
                //           style: TextStyle(color: Colors.grey),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
              );
            },
            itemCount: transactionList.length,
          );
  }
}
