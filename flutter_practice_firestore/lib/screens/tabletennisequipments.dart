import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firestore/screens/equipmenttimeentry.dart';
import 'package:flutter_practice_firestore/screens/orderconfirmation.dart';
import 'package:flutter_practice_firestore/screens/sports.dart';

var controllers = [TextEditingController(), TextEditingController()];

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
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the text that the user has entered into the text field.
        onPressed: (){
          orders = [];
          String order1 = controllers[0].text;
          String order2 = controllers[1].text;
          int or1 = int.parse(order1);
          int or2 = int.parse(order2);
          orders.add(or1);
          orders.add(or2);
          print(orders);
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => OrderConfirmation(),
            ),
          );
        }  ,
        tooltip: 'Show me the value!',
        child: Text(
          'Next',
        ),
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllers[0].dispose();
    controllers[1].dispose();  
    super.dispose();
  }

  
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
                print("Hey");
              },
              child: Column(                
                children: [Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  color: Colors.blue[200],
                  child: ListTile(
                  title: new Text(
                    document.data()['name'] + " " + availability_1[document.data()['availabilityindex']].toString() , 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  //subtitle: new Text(document.data()['description']),
                )),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  child: TextFormField(
                    controller: controllers[document.data()['availabilityindex']],
                    decoration: const InputDecoration(
                      hintText: 'Enter Quantity',
                    ),
                  )
                )]
              ),
            );
          }).toList(),  
        );
      },
    );
  }
}
