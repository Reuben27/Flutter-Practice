import 'package:flutter/material.dart';
import 'package:flutter_practice_firestore/screens/entry.dart';
import 'package:flutter_practice_firestore/screens/squashequipments.dart';
import 'package:flutter_practice_firestore/screens/squashrooms.dart';

class Squash extends StatefulWidget {
  @override
  _SquashState createState() => _SquashState();
}

class _SquashState extends State<Squash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Allocation System'),
          centerTitle: true,
      ),
      body: Center(
        child: RoomorEquipments(),
      ),
    );
  }
}

class RoomorEquipments extends StatefulWidget {
  @override
  _RoomorEquipmentsState createState() => _RoomorEquipmentsState();
}

class _RoomorEquipmentsState extends State<RoomorEquipments> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => SquashRooms(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              color: Colors.blue[200],
              child: ListTile(
                title: new Text(
                  'Rooms', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                    ),
                  ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Entry(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              color: Colors.blue[200],
              child: ListTile(
                title: new Text(
                  'Equipments', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                    ),
                  ),
              ),
            ),
          ),
        ],        
    );
  }
}

