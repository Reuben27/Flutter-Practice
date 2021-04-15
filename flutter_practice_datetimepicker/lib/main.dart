import 'package:flutter/material.dart';
import 'package:flutter_practice_datetimepicker/datepicker.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allocation System',
      home: DateTimePicker(),
    );
  }
}