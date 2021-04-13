import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableTennisRooms extends StatefulWidget {
  @override
  _TableTennisRoomsState createState() => _TableTennisRoomsState();
}

class _TableTennisRoomsState extends State<TableTennisRooms> {
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
    CollectionReference sports = FirebaseFirestore.instance.collection('TableTennisRooms');

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
                print(document.data()['roomname']);
                print(document.data()['bookedslots']);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    document.data()['roomname'], 
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