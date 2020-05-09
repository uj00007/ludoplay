import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ludoplay/components/dice.dart';
import 'package:ludoplay/components/ludo_board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
