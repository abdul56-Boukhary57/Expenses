import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:test_expenses/widgets/chart/chart.dart";
import "package:test_expenses/widgets/expenses.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      home: Expenses(),
    );
  }
}
