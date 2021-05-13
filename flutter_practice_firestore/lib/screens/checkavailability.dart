import 'package:cloud_firestore/cloud_firestore.dart';

int micros = 1;
List<int> availability = [];
//Table Tennis Ball , Table Tennis Racket
//Squash Ball, Squash Racket

List<int> checkavailability(starttime, endtime){
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
      availability.add(currentquantity);
    });
  });

  return availability;
}