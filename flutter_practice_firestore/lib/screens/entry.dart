import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Booking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allocation System'),
        centerTitle: true,
      ),
      body: UserEntry(),
    );
  }
}

class UserEntry extends StatefulWidget {
  @override
  _UserEntryState createState() => _UserEntryState();
}

class _UserEntryState extends State<UserEntry> {
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
        _dateController.text = DateFormat.yMd().format(selectedDate);
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
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeControllerEntry.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
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
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '',
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
          print("");
          print("**************************");
          print(_minuteEntry);
          print(_timeEntry);
          print(_timeExit);
          print(selectedDate);
          String newdate = DateFormat('yyyy-MM-dd').format(selectedDate);
          print(newdate);
          if(int.parse(_hourEntry) < 10){
            newdate = newdate + " 0" + _hourEntry;
          }
          else{
            newdate = newdate + " " + _hourEntry;
          }

          if(int.parse(_minuteEntry) < 10){
            newdate = newdate + ":0" + _minuteEntry + ":" + "00.000";
          }
          else{
            newdate = newdate + ":" + _minuteEntry + ":" + "00.000";
          }
           
          print(newdate);  
          DateTime parser = DateTime.parse(newdate);
          print(parser);        
          print("**************************");
          print("");
          print("");
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Book',
        ),
      ),
    );
  }
}
