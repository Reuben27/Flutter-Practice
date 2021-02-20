import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_view.dart';
import 'package:crypto_wallet/net/api_methods.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  // ignore: must_call_super
  initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else {
        return (tether * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height, 
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('Coins')
            .snapshots() ,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }     

            return ListView(
              children: snapshot.data.docs.map((document) {
                return Padding(
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.3,
                    height: MediaQuery.of(context).size.height/12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Coin: ${document.id}" , 
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text("Amount: \$${getValue(document.id, document.data()['Amount'])}", 
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ), 
                          onPressed: () async {
                            await removeCoin(document.id);
                          },
                        )
                      ],
                    ),
                  ),
                  padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddView(),
          ));
        },
        child: Icon(Icons.add, color: Colors.green[800]),
        backgroundColor: Colors.white,
      ),
    );
  }
}