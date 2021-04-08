import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class ExerciseData {
  String id;
  String name;
  String url;
  String description;
  String category;
  String type;

  ExerciseData( this.id, this.name, this.url, this.description, this.category);

  factory ExerciseData.fromJson(dynamic json) {
    return ExerciseData("${json['id']}", "${json['name']}", "${json['url']}", "${json['description']}", "${json['category']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'description' : description,
        'category' : category,
      };
}

class GetData{
  static const URL = "https://script.google.com/macros/s/AKfycbx2H4v8xaSWlnTq3WKaVHw-Z_2eBh6M0yFufxGwm-diDYcKfJPzHZjI9zi23Z1G0YSF/exec";
  Future<List<ExerciseData>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => ExerciseData.fromJson(json)).toList();
    });
  }
}



class _MyAppState extends State<MyApp> {
  // ignore: deprecated_member_use
  List<ExerciseData> exercises = List<ExerciseData>();

  @override
  void initState() {
    super.initState();

    GetData().getFeedbackList().then((exercises) {
      setState(() {
        this.exercises = exercises;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Sheet Data'),
          backgroundColor: Colors.green[700],
        ),
        body: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        "${exercises[index].name} - ${exercises[index].description}"),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
