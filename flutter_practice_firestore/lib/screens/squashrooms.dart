import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firestore/screens/sports.dart';
import 'package:flutter_practice_firestore/screens/roombooking.dart';

class SquashRooms extends StatefulWidget {
  @override
  _SquashRoomsState createState() => _SquashRoomsState();
}

class _SquashRoomsState extends State<SquashRooms> {
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
    CollectionReference squashrooms = FirebaseFirestore.instance.collection('SquashRooms');

    return StreamBuilder<QuerySnapshot>(
      stream: squashrooms.snapshots(),
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
                selectedroomid = document.id;
                selectedroomname = document.data()['roomname'];
                selectedroomtype = "SquashRooms";
                print("");
                print("**************************");
                print(selectedsportid);
                print(document.data()['roomname']);
                print(document.data()['bookedslots']);
                print(document.id);
                print("**************************");
                print("");
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => Booking(),
                    ),
                  );
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

