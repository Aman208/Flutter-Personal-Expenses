import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/chartbar.dart';
import './transaction.dart';

class Chart extends StatelessWidget {
 final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedRecentTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (int i = 0; i < recentTransaction.length; ++i) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedRecentTransaction.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedRecentTransaction);
    return Container(
      child: Card(
          elevation: 8,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: groupedRecentTransaction.map((data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      data['day'],
                      data['amount'],
                      (totalSpending == 0.0)  ? 0.0 :(data['amount'] as double) / totalSpending,
                    ),
                  );
                }).toList()),
          )),
    );
  }
}
