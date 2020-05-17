import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ludoplay/components/dice.dart';
import 'package:ludoplay/components/ludo_board.dart';
import 'package:ludoplay/utils/common.dart';
import 'package:ludoplay/utils/dice_json_setter.dart';
import 'package:ludoplay/utils/locator.dart';
import 'dart:io' show Platform;

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
    if (Platform.isAndroid) {
      app = await FirebaseApp.configure(
          name: 'ludo-192cc',
          options: const FirebaseOptions(
              googleAppID: '1:433188034501:android:f50f52b4597a6f74b39dac',
              apiKey: '433188034501',
              databaseURL: 'https://ludo-192cc.firebaseio.com/'));
      database = FirebaseDatabase(app: app);
    } else {
      app = await FirebaseApp.configure(
          name: 'ludo-192cc',
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBK9YFMvr-W-vhV9wQRdrNn4k6gh5ZzIaA',
              googleAppID: '1:433188034501:ios:fb8dff895d926947b39dac',
              gcmSenderID: '433188034501',
              databaseURL: 'https://ludo-192cc.firebaseio.com/'));
      database = FirebaseDatabase(app: app);
    }
    print("gooottttt");
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

  Widget diceQueue(player1, player2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        diceQueueWidgetMaker(player1),
        diceQueueWidgetMaker(player2),
      ],
    );
  }

  diceQueueWidgetMaker(player) {
    List queue = players[player]['diceQueue'];
    List widgetList = [];
    queue.forEach((item) {
      widgetList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          width: 30,
          child: Image.asset(
            diceFrontImageSetter(item),
          ),
        ),
      ));
    });

    return Container(
      height: 46,
      width: MediaQuery.of(context).size.width / 2.8,
      child: Row(children: <Widget>[...widgetList]),
      decoration:
          BoxDecoration(border: Border.all(width: 0.3, color: Colors.white)),
    );
  }

  var players = {
    1: {"color": "0xffFE4D5A", "diceQueue": []},
    2: {"color": "0xff15D48F", "diceQueue": []},
    3: {"color": "0xff216AE6", "diceQueue": []},
    4: {"color": "0xffFFD260", "diceQueue": []}
  };
  var currentPlayer = 1;

  turnSwitcher() {
    print('called');
    diceQueueClear();
    if (currentPlayer == 4) {
      currentPlayer = 1;
    } else {
      currentPlayer += 1;
    }
    this.setState(() {
      this.currentPlayer = currentPlayer;
    });
  }

  diceQueueAdder(val) {
    Map playersUpdated = this.players;
    var timer;
    var timer2;
    timer2 = Timer(Duration(seconds: 3), () {
      playersUpdated[currentPlayer]['diceQueue'].add(val);
      this.setState(() {
        this.players = playersUpdated;
      });
      timer2.cancel();
      timer = Timer(Duration(seconds: 2), () {
        if (val != 6) {
          turnSwitcher();
        } else if (val == 6 &&
            playersUpdated[currentPlayer]['diceQueue'].length == 3) {
          turnSwitcher();
        }
        timer.cancel();
      });
    });

    // timer.cancel();
  }

  diceQueueClear() {
    Map playersUpdated = this.players;
    playersUpdated[currentPlayer]['diceQueue'].clear();
    this.setState(() {
      this.players = playersUpdated;
    });
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
                diceQueue(1, 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LudoBoard(
                    size: MediaQuery.of(context).size.width,
                  ),
                ),
                diceQueue(4, 3),
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
                  height: 100,
                  color: Color(int.parse(players[this.currentPlayer]["color"])),
                ),
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
                  // playerTurn: 1,
                  turnSwitchCallback: () => turnSwitcher(),
                  diceQueueListAdderFunction: (val) => diceQueueAdder(val),

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
