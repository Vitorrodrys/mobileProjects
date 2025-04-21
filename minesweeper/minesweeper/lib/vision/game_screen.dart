import 'package:flutter/material.dart';
import 'package:minesweeper/vision/ceil.dart';
import 'package:minesweeper/control/game_board.dart';

const int BOARDDIMENSION = 10;
const int MINECOUNT = 5;

class MinesweeperScreen extends StatefulWidget {

  MinesweeperScreen({super.key});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperState();
}


class _MinesweeperState extends State<MinesweeperScreen> {

  bool _finish = false;
  GameBoard _board = GameBoard(mineCount: MINECOUNT, boardSize: BOARDDIMENSION);
  String _warning = "";
  TextStyle _warningStyle = const TextStyle(
    fontSize: 30,
    color: Colors.red,
  );

  void _restart(){
    _board = GameBoard(mineCount: MINECOUNT, boardSize: BOARDDIMENSION);
    _warning = "";
    _warningStyle = const TextStyle(
      fontSize: 30,
      color: Colors.red,
    );
    _finish = false;
  }

  String _evaluate_content(int bvalue){
    if (bvalue == MINEVALUE){
      return "💣";
    }
    if (bvalue == HIDDENVALUE){
      return "";
    }
    return bvalue.toString();
  }
  void _onClickCeil((int, int) ceilCord){
    if (_finish){
      _warning = "The game finished, please restart to play again";
      _warningStyle = const TextStyle(
        fontSize: 30,
        color: Colors.red,
      );
      return;
    }
    if ( ! _board.revealCeil(ceilCord)){
      _warning = "Game Over";
      _warningStyle = const TextStyle(
        fontSize: 30,
        color: Colors.red,
      );
      _finish = true;
      _board.showBombs();
      return;
    }
    if (_board.isWin()){
      _warning = "You Win";
      _warningStyle = const TextStyle(
        fontSize: 30,
        color: Colors.green,
      );
      _finish = true;
      _board.showBombs();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding minesweeper screen");
    return Scaffold(
      appBar: AppBar(
        title: null,
        toolbarHeight: 40,
        backgroundColor: Colors.blueGrey,
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _warning,
              style: _warningStyle
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: (){
                setState(
                  () {
                    _restart();
                  }
                );
              },
            )
          ],
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: BOARDDIMENSION,
          children: List.generate(
            BOARDDIMENSION*BOARDDIMENSION,
            (index) {
              int rowIndex = index ~/ BOARDDIMENSION;
              int columnIndex = index % BOARDDIMENSION;
              return Ceil(
                onTap: (){
                  setState(
                    () {
                      _onClickCeil((rowIndex, columnIndex));
                    }
                  );
                },
                content: _evaluate_content(_board.getCeil((rowIndex, columnIndex)))
              );
            }
          ),
        ),
      )
    );
    
  }
}