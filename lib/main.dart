import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ludoplay/components/dice.dart';
import 'package:ludoplay/components/ludo_board.dart';
import 'package:ludoplay/utils/common.dart';
import 'package:ludoplay/utils/locator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  FirebaseApp app;
  FirebaseDatabase database = locator<FirebaseDatabase>();
  @override
  void initState() {
    super.initState();
    setupdatabase();
  }

  void setupdatabase() async {
    app = await FirebaseApp.configure(
        name: 'ludo-192cc',
        options: const FirebaseOptions(
            googleAppID: '1:433188034501:android:f50f52b4597a6f74b39dac',
            apiKey: '433188034501',
            databaseURL: 'https://ludo-192cc.firebaseio.com/'));
    database = FirebaseDatabase(app: app);
    // getEvent();
  }

  getEvent() {
    database.reference().child('games').onChildChanged.listen((Event e) {
      print('event updated called');
      print(e.snapshot.value);
    });
    // database.reference().child('games').onChildAdded.listen((Event e) {
    //   print('event added called');

    //   print(e.snapshot.value);
    // });
    // database.reference().child('games').once().then((DataSnapshot snapshot) {
    //   // print('value ${snapshot.value}');
    //   if (snapshot.value != null) {
    //     print(snapshot.value);
    //   }
    // });
  }

  Widget diceQueue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          // height: 40,
          width: MediaQuery.of(context).size.width / 2.8,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/dice1-front.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/dice1-front.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/dice1-front.png",
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Colors.white)),
        ),
        Container(
          // height: 40,
          width: MediaQuery.of(context).size.width / 2.8,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/dice1-front.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/dice1-front.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/dice1-front.png",
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Colors.white)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B142A),
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Dice(),
                diceQueue(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LudoBoard(
                    size: MediaQuery.of(context).size.width,
                  ),
                ),
                diceQueue(),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Dice(
                  size: 180.0,
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
