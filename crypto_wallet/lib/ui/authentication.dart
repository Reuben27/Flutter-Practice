import 'package:flutter/material.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'home_view.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _emailField,
                decoration: InputDecoration(
                  hintText: "xyz@gmail.com",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _passwordField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNaviagte = await register(_emailField.text, _passwordField.text);
                  if(shouldNaviagte){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(),
                      ),
                    );
                  }
                },
                child: Text("Register"),
              )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNaviagte = await signIn(_emailField.text, _passwordField.text);
                  if(shouldNaviagte){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(),
                      ),
                    );
                  }
                },
                child: Text("Login"),
              )
            ),
        ],)
      ),
    );
  }
}