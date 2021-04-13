import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_practice_firestore/screens/sports.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Method needed to initialize firebase application.
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allocation System',
      home: Sports(),
    );
  }
}