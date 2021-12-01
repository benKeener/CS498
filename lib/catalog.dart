import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';
import 'main.dart';


void main() {
  initializeApp(
      apiKey: "AIzaSyDyfP3aTF39_rq5-v3y32c1zaMEKCmwvqE",
      authDomain: "86501213007-cr56drmg6cug69uthdikcnl4vuarb3dg.apps.googleusercontent.com",
      databaseURL: "https://cs498data-default-rtdb.firebaseio.com",
      projectId: "cs498data",
      storageBucket: "cs498data.appspot.com");

  runApp(MyApp());
}

class MyCatalog extends StatefulWidget {
  MyCatalog({required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  int _counter = 0;
  String _datashot = "None";
  String setString = " ";
  Database db = database();



  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      DatabaseReference ref;


      ref = db.ref(myController.text);

      ref.onValue.listen((e) {
        DataSnapshot datasnapshot = e.snapshot;
        // Do something with datasnapshot
        if (datasnapshot.hasChildren()) {
          _datashot = datasnapshot.child("0").val().toString();
          setString = _datashot;
        }

      });
    });
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        child: Column(

          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Search Bar: '
            ),
            TextField(
              controller: myController,
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Your data value is ',
            ),
            Text(
              '$setString',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),

        padding: const EdgeInsets.all(16.0),
      ),

      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: _incrementCounter,
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule Your Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Professor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course Catalog',
          ),
        ],
        unselectedItemColor: Colors.blue,
        selectedItemColor: Colors.amber[800],
      ),

    );
  }
}