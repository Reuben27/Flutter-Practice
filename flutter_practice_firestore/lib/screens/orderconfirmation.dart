import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_firestore/screens/checkavailability.dart';
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
        onPressed: (){

        },
        tooltip: 'Show me the value!',
        child: Text(
          'Confirm',
        ),
      ),
    );
  }
}

int infogetter(String starttime, String endtime, List<int> orders, String equipmentid, List <int> availability, Map<String, List> equipmentsname){
  CollectionReference equipments = FirebaseFirestore.instance.collection(equipmentid);

  int length = orders.length;
  for(int i = 0; i < length; i++){
    if(orders[i] != 0){
      int availability_number = availability[i] - orders[i];
      var bookedslots = {};
      int numberofbookedslots = 0;
      String docname = equipmentsname[selectedsportid][i];

      equipments.doc(docname).get().then((DocumentSnapshot documentSnapshot){
        bookedslots = documentSnapshot.data()['bookedslots'];
        numberofbookedslots = documentSnapshot.data()['numberofbookedslots'];

        //call updater function
      });
    }
  }

  /*
  var bookedSlots = { 
    '0':  { 'availability': 15, 
            'time': { '0': "", '1': ""},
          },
  };*/
}