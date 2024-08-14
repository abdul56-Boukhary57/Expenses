

import "package:flutter/material.dart";

import "../../models/expense.dart";
import "expenses_item.dart";

class ExpensesList extends StatefulWidget {
  final List<Expense> listExpenses;
  final void Function(Expense expense) removeExpense;

  const ExpensesList(this.listExpenses, this.removeExpense, {super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    List expenses = widget.listExpenses;
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
              color: Colors.red,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25)),
          child: ExpensesItem(expenses[index]),
          onDismissed: (direction) => widget.removeExpense),
    );
  }
}
