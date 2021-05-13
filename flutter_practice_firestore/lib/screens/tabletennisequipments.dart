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
  final myController = TextEditingController(); // Name

  var controllers = [TextEditingController(), TextEditingController()];
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();  
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
              },
              child: Column(                
                children: [Container(
                  margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  color: Colors.blue[200],
                  child: ListTile(
                  title: new Text(
                    document.data()['name'] + " " + availability[document.data()['availabilityindex']].toString() , 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  //subtitle: new Text(document.data()['description']),
                )),
                TextFormField(
                  controller: controllers[document.data()['availabilityindex']],
                  decoration: const InputDecoration(
                    hintText: 'Enter Quantity',
                  ),
                )]
              ),
            )
            ;
          }).toList(),  
        );
      },
    );
  }
}
