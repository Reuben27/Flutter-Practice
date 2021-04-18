import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firestore/screens/squash.dart';
import 'package:flutter_practice_firestore/screens/tabletennis.dart';

String selectedsportid = "";
String selectedroomid = "";
String selectedroomname = "";
String selectedroomtype = "";
String selectedequipmentname = "";

class Sports extends StatefulWidget {
  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Allocation System'),
          centerTitle: true,
      ),
      body: Center(
        child: DisplayData(),
      ),
    );
  }
}

class DisplayData extends StatefulWidget {
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  
  @override
  Widget build(BuildContext context) {
    CollectionReference sports = FirebaseFirestore.instance.collection('Sports');

    return StreamBuilder<QuerySnapshot>(
      stream: sports.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(),
            );
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return GestureDetector(
              onTap: () {
                print("");
                print("**************************");
                print(document.data()['sportname']);
                print(document.data()['items']);
                print(document.data()['items']['roomtypeIds']);
                print("**************************");
                print("");
                if(document.data()['sportname'] == "Squash"){
                  selectedsportid = "squash";
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => Squash(),
                    ),
                  );
                } else if(document.data()['sportname'] == "Table Tennis"){
                  selectedsportid = "tabletennis";
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => TableTennis(),
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    document.data()['sportname'], 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  //subtitle: new Text(document.data()['description']),
                ),
              ),
            );
          }).toList(),  
        );
      },
    );
  }
}