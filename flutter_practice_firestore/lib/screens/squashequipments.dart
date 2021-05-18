import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice_firestore/screens/equipmenttimeentry.dart';
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
  var controllers = [TextEditingController(), TextEditingController()];
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllers[0].dispose();
    controllers[1].dispose();  
    super.dispose();
  }


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

