import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firestore/screens/entry.dart';
import 'package:flutter_practice_firestore/screens/sports.dart';

class SquashEquipments extends StatefulWidget {
  @override
  _SquashEquipmentsState createState() => _SquashEquipmentsState();
}

class _SquashEquipmentsState extends State<SquashEquipments> {
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
    CollectionReference squashequipments = FirebaseFirestore.instance.collection('SquashEquipments');

    return StreamBuilder<QuerySnapshot>(
      stream: squashequipments.snapshots(),
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
                print(selectedsportid);
                print(document.data()['name']);
                print(document.data()['bookedslots']);
                print(document.id);
                selectedequipmentname = document.data()['name']; 
                selectedequipmenttype = "SquashEquipments";
                selectedequipmentid = document.id;
                print("**************************");
                print("");
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    document.data()['name'], 
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

