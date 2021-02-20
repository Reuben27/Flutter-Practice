import 'package:flutter/material.dart';
import 'package:crypto_wallet/net/flutterfire.dart';

class AddView extends StatefulWidget {
  AddView({Key key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: DropdownButton(
              value: dropdownValue,
              onChanged: (String value) {
                setState(() {
                  dropdownValue = value;
                });
              },
              items: coins.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Coin Amount",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            margin: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () async {
                await addCoin(dropdownValue, _amountController.text);
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}