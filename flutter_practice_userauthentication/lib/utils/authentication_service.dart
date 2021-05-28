import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Sign Up function
Future<String?> signUp({required String firstname, required String lastname, required String email, required String password}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    User currentUser = userCredential.user!;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(currentUser.uid).set({
      "uid" : currentUser.uid,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
    }).then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));

    await currentUser.sendEmailVerification();
    
    return "A verfication link has been sent to your email. Open the link in your browser and then sign in.";

  } on FirebaseAuthException catch (e) {

    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 'The password provided is too weak. Try again.';
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 'The account already exists for that email. Try again with a different email or sign in.';
    } else {
      return 'Error. Try again.';
    }

  } catch (e) {
    print(e);
    return e.toString();
  }
}

//Sign in function
Future<List?> signIn({required String email, required String password}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User currentUser = userCredential.user!;

    CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');
    var data;
    
    /*users.doc(currentUser.uid).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) => {
      data =  documentSnapshot.data(),
    }).catchError((e) => {
      print(e.toString()),
    });*/

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await users.doc(currentUser.uid).get();
    data = documentSnapshot.data();

    if(currentUser.emailVerified){
      return ["Signed in successfully!", data, currentUser];
    } else{
      await currentUser.sendEmailVerification();
      return["error", "Your email has not yet been verified. A verification link has been sent to your email address again. Open the link and then sign in."];
    }

    
   
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return ["error", 'No user found for that email.' ];
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return ["error", 'Wrong password provided for that user.' ];
    } else{
      return ["error", "Error. Try again"];
    }
  }
}