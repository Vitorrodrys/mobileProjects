import 'package:flutter/material.dart';
import 'package:jogo_da_velha/control/game.dart';

enum GameBorderStyle{

  BottomLeft(
    Border(
      top: BorderSide(color: Colors.black, width: 2),
      right: BorderSide(color: Colors.black, width: 2)
    )
  ),
  BottorMiddle(
    Border(
      top: BorderSide(color: Colors.black, width: 2),
      left: BorderSide(color: Colors.black, width: 2),
      right: BorderSide(color: Colors.black, width: 2)
    )
  ),
  BottomRight(
    Border(
      top: BorderSide(color: Colors.black, width: 2),
      left: BorderSide(color: Colors.black, width: 2)
    )
  ),
  TopLeft(
    Border(
      bottom: BorderSide(color: Colors.black, width: 2),
      right: BorderSide(color: Colors.black, width: 2)
    )
  ),
  TopMiddle(
    Border(
      bottom: BorderSide(color: Colors.black, width: 2),
      left: BorderSide(color: Colors.black, width: 2),
      right: BorderSide(color: Colors.black, width: 2)
    )
  ),
  TopRight(
    Border(
      bottom: BorderSide(color: Colors.black, width: 2),
      left: BorderSide(color: Colors.black, width: 2)
    )
  ),
  MiddleLeft(
    Border(
      top: BorderSide(color: Colors.black, width: 2),
      bottom: BorderSide(color: Colors.black, width: 2),
      right: BorderSide(color: Colors.black, width: 2)
    )
  ),
  Middle(
    Border.fromBorderSide(
      BorderSide(color: Colors.black, width: 2)
    )
  ),
  MiddleRight(
    Border(
      top: BorderSide(color: Colors.black, width: 2),
      bottom: BorderSide(color: Colors.black, width: 2),
      left: BorderSide(color: Colors.black, width: 2)
    )
  );


  final Border style;

  const GameBorderStyle(this.style);

}

class Ceil extends StatefulWidget {

  const Ceil({super.key, required this.index, required this.onTap, required this.gameBoard, required this.border});

  final int index;
  final VoidCallback onTap;
  final Game gameBoard;
  final GameBorderStyle border;

  @override
  State<Ceil> createState() => _CeilState();
}

class _CeilState extends State<Ceil> {
  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: widget.border.style
      ),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          widget.gameBoard.get(widget.index).symbol,
          style: TextStyle(
            fontSize: 50,
            color: widget.gameBoard.get(widget.index).symbol == "X" ? Colors.red : Colors.blue,
          ),
        ),
      ),
    );
  }
}
