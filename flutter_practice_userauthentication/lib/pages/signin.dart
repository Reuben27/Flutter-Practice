import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './home.dart';
import '../utils/authentication_service.dart';

class SignInPage extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Authentication - Sign In'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //For sign up with email and password
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: emailController,
                    // ignore: missing_return
                    validator: (input) {
                      if(input!.isEmpty){    
                        return 'Provide an email' ;           
                      } else{
                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);
                        if(!emailValid){
                          return 'Provide a valid email';
                        }   
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.grey
                        ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                      )
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: passwordController,
                    // ignore: missing_return
                    validator: (input) {
                      if(input!.length < 6){
                        return 'Longer password please';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.grey
                        ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {                   
                      //call the function
                      final FormState form = _formKey.currentState!;
                      if (form.validate()) {
                        print('Form is valid');
                        List? temp = await signIn(email: emailController.text, password: passwordController.text);
                        if(temp![0] == "error"){
                          return showDialog(
                            context: context,
                            builder: (context) {
                              Widget okButton = ElevatedButton(
                                child: Text("Ok"),
                                onPressed:  () {
                                  emailController.clear();
                                  passwordController.clear();
                                  Navigator.push(context, 
                                    MaterialPageRoute(builder: (context) => SignInPage(),
                                    ),
                                  );
                                },
                              );
                              return AlertDialog(
                                content: Text(temp[1]),
                                actions: [
                                  okButton,
                                ],
                              );
                            },
                          );
                        } else{
                          print(temp[1]);
                          print(temp[2]);
                          return showDialog(
                            context: context,
                            builder: (context) {
                              Widget okButton = ElevatedButton(
                                child: Text("Ok"),
                                onPressed:  () {
                                  emailController.clear();
                                  passwordController.clear();
                                  Navigator.push(context, 
                                    MaterialPageRoute(builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                              );
                              return AlertDialog(
                                content: Text(temp[0]),
                                actions: [
                                  okButton,
                                ],
                              );
                            },
                          );                         
                        }
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //For login redirect
          Container(),
          //For Google sign in
          Container(),
        ]
      ),
    );
  }
}