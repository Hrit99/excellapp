import 'package:excelapptry/excelTojson.dart';
import 'package:excelapptry/tableShowPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/showPage": (context) => TableShowPage(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initialized = false;
  bool _error = false;
  final myController = TextEditingController();

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final fb = FirebaseDatabase.instance;
    final name = "Data";
    final ref = fb.reference();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: "uploadbtn",
                      onPressed: () {
                        // ref.child(name).set({"key1": "value1", "key2": "value2"});
                        excelToJson().then((value) {
                          ref.child(name).set(value);
                          // for (var map in value) {
                          //   ref.child(name).set(map);
                          // }
                        });
                      },
                      child: Icon(Icons.upload_file),
                    ),
                    Text("UPLOAD",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: "showbtn",
                      onPressed: () {
                        // ref.child(name).set({"key1": "value1", "key2": "value2"});
                        ref.get().then((value) {
                          // print(value.value[name]);
                          Navigator.of(context).pushNamed("/showPage",
                              arguments: value.value[name]);
                        });
                      },
                      child: Icon(Icons.remove_red_eye),
                    ),
                    Text("SHOW", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
