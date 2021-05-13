import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firestore/screens/entry.dart';
import 'package:flutter_practice_firestore/screens/sports.dart';

class TableTennisEquipments extends StatefulWidget {
  @override
  _TableTennisEquipmentsState createState() => _TableTennisEquipmentsState();
}

class _TableTennisEquipmentsState extends State<TableTennisEquipments> {
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
    CollectionReference tabletennisequipments = FirebaseFirestore.instance.collection('TableTennisEquipments');

    return StreamBuilder<QuerySnapshot>(
      stream: tabletennisequipments.snapshots(),
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
                /*
                print("");
                print("**************************");
                print(selectedsportid);
                print(document.data()['name']);
                print(document.data()['bookedslots']);
                print(document.id);
                selectedequipmentname = document.data()['name']; 
                selectedequipmenttype = "TableTennisEquipments";
                selectedequipmentid = document.id;
                print("**************************");
                print("");
                print("");
                print("");
                print("");
                print("");
                print("Reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                */
                print("Running check availabilty");
                print("");
                checkavailability(entryTime, exitTime);
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

int micros = 1;
void checkavailability(starttime, endtime){
  CollectionReference tabletennisequipments = FirebaseFirestore.instance.collection('TableTennisEquipments');
  var start = DateTime.parse(starttime);  
  //Adding microseconds to prevent isAfter from not working as intended
  start = start.add(new Duration(microseconds: micros));
  //print(start);
  var end = DateTime.parse(endtime); 
  //Adding microseconds to prevent isAfter from not working as intended
  end = end.add(new Duration(microseconds: micros));
  //print(end);
  micros += 1;
  print("Time Slots: " + starttime + " to " + endtime);

  tabletennisequipments.get().then((QuerySnapshot querySnapshot){
    querySnapshot.docs.forEach((doc){
      print("Checking for " + doc['name']);
      //print(doc['name'] + " " + doc['totalquantity'].toString());
      //print(doc['bookedslots']);
      var bookedSlots = doc['bookedslots'];
      var n = doc['numberofbookedslots'];
      var currentquantity = doc['totalquantity'];

      /*
      print("");
      print("");
      print(currentquantity);
      print(bookedSlots);
      print(n);
      print("Timings");
      print(start);
      print(end);
      print("");
      print("");
      */

      for(int j = 0; j < n; j++){
        /*
        print("Hey");
        print(bookedSlots[j.toString()]['availability']);
        print("Hey 2");
        print(bookedSlots[j.toString()]['time']['0']);
        print("Hey 3");
        */

        if((DateTime.parse(bookedSlots[j.toString()]['time']['0']).isAfter(start)  && DateTime.parse(bookedSlots[j.toString()]['time']['0']).isBefore(end)) || (DateTime.parse(bookedSlots[j.toString()]['time']['1']).isAfter(start)  && DateTime.parse(bookedSlots[j.toString()]['time']['1']).isBefore(end))){
          //print("Hey 4");
          if(currentquantity > bookedSlots[j.toString()]['availability']){
            //print("Hey 5");
            currentquantity = bookedSlots[j.toString()]['availability'];
          } 
        }
      }

      print("For the chosen time slot, the quantity available is - " + currentquantity.toString());
      print(" ");
      //print(currentquantity);
    });
  });
}