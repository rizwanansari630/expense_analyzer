import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String amount;
  final String day;
  final double avgOfWeek;

  ChartBar(this.amount, this.day, this.avgOfWeek);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text('₹$amount'),
                fit: FittedBox().fit,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.65,
              width: 10,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: avgOfWeek,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(day)),
            ),
          ],
        );
      }),
    );
  }
}
