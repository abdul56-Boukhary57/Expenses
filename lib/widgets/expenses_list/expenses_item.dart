

import 'package:flutter/material.dart';

import '../../models/expense.dart';


class ExpensesItem extends StatelessWidget {

  final Expense expense;
  const ExpensesItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: const EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(expense.title)),
                // Icon(categoryIcon[expense.category]),
                // const CircularProgressIndicator.adaptive(),
                const SizedBox(width: 6),
                Text(expense.formattedDate)
              ],
            ),
            const SizedBox(height: 10),
            Text('\$${expense.amount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
