import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/recent_transactions_model.dart';
import '../models/transaction_model.dart';
import 'chart_bar.dart';

class ExpenseChart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  double totalSpending = 0;

  ExpenseChart(this.recentTransactions);

  List<RecentTransactions> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        print(DateTime.now());
        double totalSum = 0;
        for (var i = 0; i < recentTransactions.length; i++) {
          totalSpending += recentTransactions[i].amount;
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }
        return RecentTransactions(
            day: DateFormat.E().format(weekDay).substring(0, 1),
            sumOfDay: totalSum,
            AvgOfDay: 0);
      },
    ).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum += item.sumOfDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < groupedTransactionValues.length; i++) {
      print(
        "Day : ${groupedTransactionValues[i].day}, Sum : ${groupedTransactionValues[i].sumOfDay}, AvgOfDay : ${groupedTransactionValues[i].AvgOfDay}",
      );
    }
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((rTx) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  rTx.sumOfDay.toString(),
                  rTx.day,
                  (rTx.sumOfDay as double) / maxSpending,
                ));
          }).toList(),
        ),
      ),
    );
  }
}
