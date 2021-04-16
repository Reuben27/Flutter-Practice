import 'package:flutter/material.dart';
import 'package:flutter_practice_firestore/screens/tabletennisequipments.dart';
import 'package:flutter_practice_firestore/screens/tabletennisrooms.dart';

class TableTennis extends StatefulWidget {
  @override
  _TableTennisState createState() => _TableTennisState();
}

class _TableTennisState extends State<TableTennis> {
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
                MaterialPageRoute(builder: (context) => TableTennisRooms(),
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
                MaterialPageRoute(builder: (context) => TableTennisEquipments(),
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

