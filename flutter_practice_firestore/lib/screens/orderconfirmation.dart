import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_firestore/screens/checkavailability.dart';
import 'package:flutter_practice_firestore/screens/equipmenttimeentry.dart';
import 'package:flutter_practice_firestore/screens/sports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderConfirmation extends StatefulWidget {
  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Allocation System'),
          centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index){
            String quantity = orders[index].toString();
            String equipname = equipmentsname[selectedsportid][index];
            return ListTile(
              title: new Text(
                equipname + '   ' + quantity, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue, 
                  fontWeight: FontWeight.bold
                ),
              ),
            );
          }),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the text that the user has entered into the text field.
        onPressed: () async{
          print(entryTime);
          print(exitTime);
          print(orders);
          print(selectedequipmenttype);
          print(availability);
          print(equipmentsname);
          await infogetter(entryTime, exitTime, orders, selectedequipmenttype, availability, equipmentsname );

          print("Datatatatata update6wgqsyudgwhcgagdfvwdhsdcvwcyg");
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Confirm',
        ),
      ),
    );
  }
}

Future<void> infogetter(String starttime, String endtime, List<int> orders, String equipmentid, List <int> availability, Map<String, List> equipmentsname) async {
  CollectionReference equipments = FirebaseFirestore.instance.collection(equipmentid);

  int length = orders.length;
  for(int i = 0; i < length; i++){
    if(orders[i] != 0){
      int availabilityNumber = availability[i] - orders[i];
      var bookedslots = {};
      int numberofbookedslots = 0;
      String docname = equipmentsname[selectedsportid][i];

      DocumentSnapshot documentSnapshot = await equipments.doc(docname).get();
      print("hey");
      if(documentSnapshot.exists){
        bookedslots = await documentSnapshot.data()['bookedslots'];
        print(bookedslots);
        numberofbookedslots = await documentSnapshot.data()['numberofbookedslots'];

      } else{
        print("no data buoid");
      }
      

      bookedslots[numberofbookedslots.toString()] = {
        'availability' : availabilityNumber,
        'time' : { '0': starttime, '1': endtime},
      };

      numberofbookedslots += 1;

      int doneornot = await updater(docname, bookedslots, numberofbookedslots, equipmentid);

      if(doneornot == 1){
        print("Data updated");
      } else{
        print("Data not updated");
      }
    }
  }
}

Future<int> updater (String docname, var bookedslots, int numberofbookedslots, String equipmentid) async{
  CollectionReference equipments = FirebaseFirestore.instance.collection(equipmentid);
  
  try{
    await equipments.doc(docname).update({
      'bookedslots': bookedslots,
      'numberofbookedslots': numberofbookedslots,
    });

    return 1;
  } catch (e){
    print(e);
    return 0;
  }
}