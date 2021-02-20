import 'package:flutter/material.dart';
//Lesson 6, 7, 8 of Flutter Tutorial for Beginners - Net Ninja

void main() => runApp(MaterialApp(
  home: Home(), //Using custom widget
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {//Responsible for building up the widget tree inside the Statless Home Widget
    //Returning a widget tree. So whenever we change something in the widget tree, flutter detects it, and the build function reloads it.
    //Hot Reload in action
    return Scaffold(
      appBar: AppBar(
          title: Text('my first app'),
          centerTitle: true,
          backgroundColor: Colors.red[600]
      ),
      body: Center(
        //Instead of a Image widget you can directly use child: Image.asset('<url>'),
        child: Image(
          //Using online images.
          //image: NetworkImage('https://i.pinimg.com/originals/f2/d8/5c/f2d85c0ead75501fe94c08675d3f61a3.jpg'),
          //Using asset images.
          //To do this first update the pubspec.yaml file to include the assets.
          image: AssetImage('assets/red2.jpg'),
        ),
        /*child: Text(
          'hello, ninjas!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[600],
          ), Text Style
        ), Text Widget*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.red[600],
        child: Text('Click'),
      ),
    );
  }
}
