import 'package:flutter/material.dart';

class LudoBoard extends StatefulWidget {
  var size;
  LudoBoard({Key key, this.size = 200.0}) : super(key: key);

  @override
  _LudoBoardState createState() => _LudoBoardState();
}

class _LudoBoardState extends State<LudoBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        // The base chessboard image
        children: <Widget>[
          Center(
            child: Container(
              height: widget.size,
              width: widget.size,
              child: buildLudoBoard(),
            ),
          ),
          // Container(
          //   height: widget.size,
          //   width: widget.size,
          //   child: Image.asset(
          //     "assets/images/ludo_board.png",
          //   ),
          // ),

          //Overlaying draggables/ dragTargets onto the squares
        ],
      ),
    );
  }

  Widget buildLudoBoard() {
    var tiles = [
      // [
      //   1,
      //   2,
      //   3,
      //   4,
      //   5,
      //   6,
      //   7,
      //   8,
      //   9,
      //   10,
      //   11,
      //   12,
      //   13,
      //   14,
      //   15,
      // ]
    ];
    int val = 1;
    for (int i = 1; i <= 15; i++) {
      var temp = [];
      for (int j = 1; j <= 15; j++) {
        temp.add(val);
        val++;
      }
      tiles.add(temp);
    }
    print(tiles.length);
    print(tiles[0].length);
    return Column(
        children: tiles.map((row) {
      return LudoBoardRow(
        children: row,
        // game: game,
        // size: widget.size,
        // onMove: widget.onMove,
        // refreshBoard: refreshBoard,
        // enableUserMoves: widget.enableUserMoves,
      );
    }).toList());
  }
}

class LudoBoardRow extends StatelessWidget {
  // Children are the squares in the row.
  final List<dynamic> children;
  // final chess.Chess game;
  // final double size;
  // final MoveCallback onMove;
  // final Function refreshBoard;
  // final bool enableUserMoves;

  LudoBoardRow({
    this.children = const [],
    // @required this.game,
    // this.size,
    // this.onMove,
    // this.refreshBoard,
    // this.enableUserMoves
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: children
            .map((squareName) => BoardTile(squareName: squareName))
            .toList(),
      ),
    );
  }
}

class BoardTile extends StatefulWidget {
  final int squareName;

  const BoardTile({Key key, this.squareName}) : super(key: key);

  @override
  _BoardTileState createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    if (isRed(widget.squareName))
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(color: Color(0xffFE4D5A)),
        ),
      );
    if (isGreen(widget.squareName))
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(color: Color(0xff15D48F)),
        ),
      );
    if (isYellow(widget.squareName))
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(color: Color(0xffFFD260)),
        ),
      );
    if (isBlue(widget.squareName))
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(color: Color(0xff216AE6)),
        ),
      );
    if (isHome(widget.squareName))
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(color: Color(0xff32384F)),
        ),
      );
    return Expanded(
      flex: 1,
      child: Container(
        decoration:
            BoxDecoration(color: Colors.white, border: Border.all(width: 0.3)),
      ),
    );
  }

  bool isRed(val) {
    if ((val >= 1 && val <= 6) ||
        (val >= 16 && val <= 21) ||
        (val >= 31 && val <= 36) ||
        (val >= 46 && val <= 51) ||
        (val >= 61 && val <= 66) ||
        (val >= 76 && val <= 81) ||
        (val >= 107 && val <= 111) ||
        val == 92) {
      return true;
    }
    return false;
  }

  bool isGreen(val) {
    if ((val >= 10 && val <= 15) ||
        (val >= 25 && val <= 30) ||
        (val >= 40 && val <= 45) ||
        (val >= 55 && val <= 60) ||
        (val >= 70 && val <= 75) ||
        (val >= 85 && val <= 90) ||
        ([23, 38, 53, 68, 83].contains(val)) ||
        val == 24) {
      return true;
    }
    return false;
  }

  bool isYellow(val) {
    if ((val >= 136 && val <= 141) ||
        (val >= 151 && val <= 156) ||
        (val >= 166 && val <= 171) ||
        (val >= 181 && val <= 186) ||
        (val >= 196 && val <= 201) ||
        (val >= 211 && val <= 216) ||
        ([203, 188, 173, 158, 143].contains(val)) ||
        val == 202) {
      return true;
    }
    return false;
  }

  bool isBlue(val) {
    if ((val >= 145 && val <= 150) ||
        (val >= 160 && val <= 165) ||
        (val >= 175 && val <= 180) ||
        (val >= 190 && val <= 195) ||
        (val >= 205 && val <= 210) ||
        (val >= 220 && val <= 225) ||
        (val >= 115 && val <= 119) ||
        val == 134) {
      return true;
    }
    return false;
  }

  bool isHome(val) {
    if ((val >= 112 && val <= 114) ||
        (val >= 127 && val <= 129) ||
        (val >= 97 && val <= 99)) {
      return true;
    }
    return false;
  }
}
