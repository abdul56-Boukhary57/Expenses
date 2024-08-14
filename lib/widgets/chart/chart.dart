import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_expenses/widgets/chart/chart_bar.dart';

import '../../models/expense.dart';

class Chart extends StatelessWidget {
  final List<Expense> expenses;

  const Chart({super.key, required this.expenses});

  List<BucketExpenses> get buckets {
    return [
      BucketExpenses.forCategory(expenses, Category.work),
      BucketExpenses.forCategory(expenses, Category.food),
      BucketExpenses.forCategory(expenses, Category.travel),
      BucketExpenses.forCategory(expenses, Category.leisure)
    ];
  }

  double get maxTotalAmount {
    double max = 0;
    for (var e in buckets) {
      if (e.totalAmountExpense > max) max = e.totalAmountExpense;
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        log(constraints.maxHeight);
        log(constraints.minHeight);
        log(constraints.maxWidth);
        log(constraints.minWidth);
        return Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var e in buckets)
                      ChartBar(
                          fill: e.totalAmountExpense == 0
                              ? 0
                              : e.totalAmountExpense / maxTotalAmount),
                  ],
                ),
              ),
              constraints.minHeight < 200
                  ? Container()
                  : const SizedBox(height: 12),
              constraints.minHeight < 200
                  ? Container()
                  : Expanded(
                      child: Row(
                        children: buckets
                            .map(
                              (e) => Expanded(
                                  child: Icon(categoryIcon[e.category],
                                      color: Colors.white)),
                            )
                            .toList(),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
