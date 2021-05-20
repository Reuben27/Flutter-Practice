import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_practice_firestore/screens/sports.dart';
import 'package:intl/intl.dart';

var bookedSlots = {};

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String _setTime, _setDate;

  String _hourEntry,
      _minuteEntry,
      _timeEntry,
      _hourExit,
      _minuteExit,
      _timeExit;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeControllerEntry = TextEditingController();
  TextEditingController _timeControllerExit = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMMd('en_US').format(selectedDate);
      });
  }

  Future<Null> _selectTimeEntry(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hourEntry = selectedTime.hour.toString();
        _minuteEntry = selectedTime.minute.toString();
        _timeEntry = _hourEntry + ' : ' + _minuteEntry;
        _timeControllerEntry.text = _timeEntry;
        _timeControllerEntry.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<Null> _selectTimeExit(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hourExit = selectedTime.hour.toString();
        _minuteExit = selectedTime.minute.toString();
        _timeExit = _hourExit + ' : ' + _minuteExit;
        _timeControllerExit.text = _timeExit;
        _timeControllerExit.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd('en_US').format(DateTime.now());

    _timeControllerEntry.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    _timeControllerExit.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().add(const Duration(minutes: 30)).hour, DateTime.now().add(const Duration(minutes: 30)).minute),
        [hh, ':', nn, " ", am]).toString();

    super.initState();
  }

  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController1 = TextEditingController(); // Name
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    _dateController.dispose();
    _timeControllerEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
  CollectionReference currentroom = FirebaseFirestore.instance.collection(selectedroomtype);

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Choose Date',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 10,
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        onSaved: (String val) {
                          _setDate = val;
                        },
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: 'Time',
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Choose Entry Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTimeEntry(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 10,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeControllerEntry,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Choose Exit Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTimeExit(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 10,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeControllerExit,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the text that the user has entered into the text field.
        onPressed: () {
          print("");
          print("**************************");
          print(selectedroomid);
          print(selectedroomtype);

          String starttime = DateFormat('yyyy-MM-dd').format(selectedDate);
          String endtime = DateFormat('yyyy-MM-dd').format(selectedDate);
          //print(starttime);

          if(int.parse(_hourEntry) < 10){
            starttime = starttime + " 0" + _hourEntry;
          }
          else{
            starttime = starttime + " " + _hourEntry;
          }

          if(int.parse(_minuteEntry) < 10){
            starttime = starttime + ":0" + _minuteEntry + ":" + "00.000";
          }
          else{
            starttime = starttime + ":" + _minuteEntry + ":" + "00.000";
          }

          if(int.parse(_hourExit) < 10){
            endtime = endtime + " 0" + _hourExit;
          }
          else{
            endtime = endtime + " " + _hourExit;
          }

          if(int.parse(_minuteExit) < 10){
            endtime = endtime + ":0" + _minuteExit + ":" + "00.000";
          }
          else{
            endtime = endtime + ":" + _minuteExit + ":" + "00.000";
          }
           
          print("Exit Time  " + endtime);  
          print("Entry Time " + starttime);

          currentroom.doc(selectedroomid).get().then((DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                print("");
                print("**************************");
                bookedSlots = documentSnapshot.data()['bookedslots'];
                var numberofslots = documentSnapshot.data()['numberofbookedslots'];
                print(bookedSlots);
                print("**************************");
                print("");

                //updater(starttime, endtime, numberofslots);
                if(checker(starttime, endtime, numberofslots) == 0){
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Room could not be booked. Try again.'),
                      );
                    },
                  );
                }
                else{
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Room has been booked!'),
                      );
                    },
                  );
                }

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

int updater(String starttime, String endtime, int numberofslots){
  CollectionReference currentroom = FirebaseFirestore.instance.collection(selectedroomtype);
  //update data
  String currentslot = numberofslots.toString();
  bookedSlots[currentslot] = [starttime, endtime];
  numberofslots = numberofslots + 1;
  int flagi = 1;

  currentroom.doc(selectedroomid)
        .update({
          'bookedslots': bookedSlots,
          'numberofbookedslots': numberofslots,
        })
        .then((value) => {
          print("Data Updated. Room has been booked!"),
        })
        .catchError(
            (error) => {
          print("Failed to updated data: $error"),
          flagi = 0,
        });
  
  return flagi;
}

int micros = 1;
int checker(String starttime, String endtime, int numberofslots){
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
    if(updater(starttime, endtime, numberofslots) == 0){
      return 0;
    }
    return 1;
  }
  else{
    print("Cannot be booked");
    return 0;
  }
}