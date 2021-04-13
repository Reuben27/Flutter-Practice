import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_firestore/screens/squashrooms.dart';

var bookedSlots = {};
CollectionReference squashrooms = FirebaseFirestore.instance.collection('SquashRooms');

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final myController1 = TextEditingController(); // Name
  final myController2 = TextEditingController(); // Start Time
  final myController3 = TextEditingController(); // End Time

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    

    return Scaffold(
      appBar: AppBar(
          title: Text('Allocation System'),
          centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              selectedroomname,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[500],
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController1,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController2,
              decoration: InputDecoration(
                labelText: "Enter Starting Time",
                hintText: "2021-02-21 10:00:00",
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today_rounded),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController3,
              decoration: InputDecoration(
                labelText: "Enter Ending Time",
                hintText: "2021-02-21 11:00:00",
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today_rounded),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the text that the user has entered into the text field.
        onPressed: () {
          print("");
          print("**************************");
          String name = myController1.text;
          print(name);
          String starttime = myController2.text;
          print(starttime);
          String endtime = myController3.text;
          print(endtime);
          print("**************************");
          print("");
          //get data
          squashrooms.doc(selectedroomid).get().then((DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                print("");
                print("**************************");
                bookedSlots = documentSnapshot.data()['bookedslots'];
                var numberofslots = documentSnapshot.data()['numberofbookedslots'];
                print(bookedSlots);
                print("**************************");
                print("");

                //updater(starttime, endtime, numberofslots);
                checker(starttime, endtime, numberofslots);

              } else {
                print('Document does not exist on the database');
              }
            });
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Book', 
        ),
      ),
    );
  }
}

void updater(String starttime, String endtime, int numberofslots){
  //update data
  String currentslot = numberofslots.toString();
  bookedSlots[currentslot] = [starttime, endtime];
  numberofslots = numberofslots + 1;

  squashrooms.doc(selectedroomid)
        .update({
          'bookedslots': bookedSlots,
          'numberofbookedslots': numberofslots,
        })
        .then((value) => print("Data Updated"))
        .catchError(
            (error) => print("Failed to updated data: $error"));
}

int micros = 1;
void checker(String starttime, String endtime, int numberofslots){
  var start = DateTime.parse(starttime);  
  //Adding microseconds to prevent isAfter from not working as intended
  start = start.add(new Duration(microseconds: micros));
  //print(start);
  var end = DateTime.parse(endtime); 
  //Adding microseconds to prevent isAfter from not working as intended
  end = end.add(new Duration(microseconds: micros));
  //print(end);
  micros += 1;

  print("");
  int flagRoom = -1;
  for(var j = 0; j < numberofslots; j++){
    if(((start.isAfter(DateTime.parse(bookedSlots[j.toString()][0]))) && start.isBefore(DateTime.parse(bookedSlots[j.toString()][1]))) || ((end.isAfter(DateTime.parse(bookedSlots[j.toString()][0]))) && end.isBefore(DateTime.parse(bookedSlots[j.toString()][1]))) || (((start.isAfter(DateTime.parse(bookedSlots[j.toString()][0]))) && start.isBefore(end)) && end.isBefore(DateTime.parse(bookedSlots[j.toString()][1])))){
      flagRoom = j;
      break;
    } else{
      continue;
    }
  }

  if(flagRoom == -1){
    updater(starttime, endtime, numberofslots);
  }
  else{
    print("Cannot be booked");
  }
}