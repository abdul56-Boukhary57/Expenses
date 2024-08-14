import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) addExpense;

  const NewExpense(this.addExpense, {super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  Category _selectedCateg = Category.work;
  DateTime? _selectedDate;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void _showDialog() {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
              title: const Text("Error"),
              content: const Text("Invalid Contents"),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
          )
        : showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Error"),
              content: const Text("Invalid Contents"),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: const InputDecoration(
                    labelText: 'Title', hintText: "Enter Title here"),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$',
                          labelText: 'Amount',
                          hintText: "Enter Amount here"),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No Selected Date'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: () async {
                            final DateTime now = DateTime.now();
                            final DateTime firstDate =
                                DateTime(now.year - 1, now.month, now.day);
                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: firstDate,
                                lastDate: now);
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    DropdownButton(
                        value: _selectedCateg,
                        items: Category.values
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.name.toUpperCase())))
                            .toList(),
                        onChanged: (newCat) {
                          if (newCat == null) return;
                          setState(() {
                            _selectedCateg = newCat;
                          });
                        }),
                    const Spacer(),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"))),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          final double? selectedAmount =
                              double.tryParse(_amountController.text);
                          final bool checkAmount =
                              selectedAmount == null || selectedAmount <= 0;
                          if (_titleController.text.trim().isEmpty ||
                              checkAmount ||
                              _selectedDate == null) {
                            _showDialog();
                          } else {
                            widget.addExpense(
                              Expense(
                                  title: _titleController.text,
                                  amount: selectedAmount,
                                  category: _selectedCateg,
                                  date: _selectedDate!),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Save Expense",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
