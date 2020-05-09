import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ludoplay/utils/common.dart';
import 'package:ludoplay/utils/dice_json_setter.dart';
import 'package:ludoplay/utils/random_gereator.dart';

class Dice extends StatefulWidget {
  var size;
  Dice({Key key, this.size = 60.0}) : super(key: key);

  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> with TickerProviderStateMixin {
  AnimationController _controller;
  FirebaseDatabase database = locator<FirebaseDatabase>();
  var diceNumber = randomDiceValueGenerator();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    getEvent();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getEvent() {
    database.reference().child('games').onChildChanged.listen((Event e) {
      print('event updated called');
      print(e.snapshot.value);
      if (e.snapshot.value["event"] == "DICE_ROLL") {
        diceRoll();
      }
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

  diceRoll() {
    this.setState(() {
      this.diceNumber = randomDiceValueGenerator();
    });
    _controller.repeat();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        diceRoll();
        // _controller.stop();
      },
      child: Container(
        child: Lottie.asset(
          diceImageSetter(this.diceNumber),
          width: widget.size,
          height: widget.size,
          controller: _controller,
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
