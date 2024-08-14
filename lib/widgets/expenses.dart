import "package:flutter/material.dart";
import "package:test_expenses/widgets/chart/chart.dart";

import "../models/expense.dart";
import "expenses_list/expenses_list.dart";
import "new_expense.dart";

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Expenses",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              useSafeArea: true,
              // isScrollControlled: true,
              context: context,
              builder: (ctx) => NewExpense(addExpense),
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ExpensesList(_registeredExpenses, removeExpense)),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ExpensesList(_registeredExpenses, removeExpense)),
                ],
              ),
      ),
    );
  }
}
