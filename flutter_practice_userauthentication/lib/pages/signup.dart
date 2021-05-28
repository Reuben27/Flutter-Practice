import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_userauthentication/utils/authentication_service.dart';

import 'signin.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Authentication - Sign Up'),
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
                    controller: firstnameController,
                    // ignore: missing_return
                    validator: (input) {
                      if(input!.isEmpty){      
                        return 'Provide a first name';            
                      } 
                    },
                    decoration: InputDecoration(
                      labelText: "First Name",
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
                    controller: lastnameController,
                    // ignore: missing_return
                    validator: (input) {
                      if(input!.isEmpty){    
                        return 'Provide a last name';              
                      } 
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name",
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
                        String? message = await signUp(firstname: firstnameController.text, lastname: lastnameController.text, email: emailController.text, password: passwordController.text);
                        return showDialog(
                          context: context,
                          builder: (context) {
                            Widget okButton = ElevatedButton(
                              child: Text("Ok"),
                              onPressed:  () {
                                firstnameController.clear();
                                lastnameController.clear();
                                emailController.clear();
                                passwordController.clear();
                                Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => SignUpPage(),
                                  ),
                                );
                              },
                            );
                            return AlertDialog(
                              content: Text(message!),
                              actions: [
                                okButton,
                              ],
                            );
                          },
                        );

                        
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: Text(
                      "Sign Up",
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
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Already have an account?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
              ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => SignInPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          ),
          //For Google sign in
          Container(),
        ]
      ),
    );
  }
}