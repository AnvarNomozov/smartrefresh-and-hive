import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivee/model/currency_model.dart';
import 'package:hivee/screens/home_screen.dart';
import 'package:hivee/service/currency_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyModelAdapter());
  await CurrencyService.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
