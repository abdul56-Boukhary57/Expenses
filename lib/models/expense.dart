


import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const  uid =  Uuid();
final dateFormat = DateFormat.yMd();
enum Category {food , travel , leisure , work}
const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense{
  final String id ;
  final String title ;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateFormat.format(date);
  }

  Expense({required this.title, required this.amount, required this.category , required this.date}):id = uid.v4();

}

class BucketExpenses{
  final List<Expense> expenses;
  final Category category;


  BucketExpenses(this.expenses , this.category);
  BucketExpenses.forCategory(final List<Expense> allExpenses , this.category):expenses=allExpenses.where((e) => e.category == category).toList();

  double get totalAmountExpense{
    double sum =0;
    for(var e in expenses){
      sum += e.amount;
    }
    return sum;
  }
}

