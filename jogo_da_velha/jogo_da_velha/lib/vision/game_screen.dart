import 'package:flutter/material.dart';
import 'package:jogo_da_velha/control/game.dart';
import 'package:jogo_da_velha/vision/ceil.dart';


class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.multiplayer});

  final bool multiplayer;
  final Game game = Game();

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  String _warnings = "";
  Color _warning_color = Colors.red;
  bool _has_winner = false;
  void _check_winner(){
    _warnings = ""; 
    GameSymbols winner = widget.game.check_has_winner();
    if (winner == GameSymbols.TIE){
      _warnings = "It's a tie!";
      _warning_color = GameSymbols.TIE.color;
      _has_winner = true;
      return;
    }
    if (winner != GameSymbols.EMPTY){
      _warnings = "${winner.symbol} is the winner!";
      _warning_color = winner.color;
      _has_winner = true;
    }
    
  }
  void _play(int board_index) {
    if (_has_winner){
      _warnings = "To play again, restart the game. The winner was ${widget.game.check_has_winner().symbol}";
      _warning_color = Colors.red;
      return;
    }
    if (! widget.game.take_turn(board_index)){
      _warnings = "Position is use";
      _warning_color = Colors.red;
      return;
    }
    _check_winner();
    if (widget.multiplayer){
      return;
    }
    if (_has_winner){
      return;
    }
    int best_move = widget.game.calc_better_play(widget.game.get_current_player());
    if (! widget.game.take_turn(best_move)){
      throw Exception("Error: AI tried to play in an occupied position");
    }
    _check_winner();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "It's ${widget.game.get_current_player().symbol}'s turn!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _warnings,
                  style: TextStyle(
                    color: _warning_color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ceil(
                  index: 0,
                  onTap: (){
                    setState(() {
                      _play(0);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.TopLeft,
                ),
                Ceil(
                  index: 1,
                  onTap: (){
                    setState(() {
                      _play(1);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.TopMiddle,
                ),
                Ceil(
                  index: 2,
                  onTap: (){
                    setState(() {
                      _play(2);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.TopRight,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ceil(
                  index: 3,
                  onTap: (){
                    setState(() {
                      _play(3);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.MiddleLeft,
                ),
                Ceil(
                  index: 4,
                  onTap: (){
                    setState(() {
                      _play(4);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.Middle,
                ),
                Ceil(
                  index: 5,
                  onTap: (){
                    setState(() {
                      _play(5);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.MiddleRight,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ceil(
                  index: 6,
                  onTap: (){
                    setState(() {
                      _play(6);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.BottomLeft,
                ),
                Ceil(
                  index: 7,
                  onTap: (){
                    setState(() {
                      _play(7);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.BottorMiddle,
                ),
                Ceil(
                  index: 8,
                  onTap: (){
                    setState(() {
                      _play(8);
                    });
                  },
                  gameBoard: widget.game,
                  border: GameBorderStyle.BottomRight,
                ),
              ],
            ),
            Visibility(
              visible: _has_winner,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    widget.game.reset();
                    _has_winner = false;
                    _warnings = "";
                  });
                },
                child: Text("Restart"),
              )
            )
          ],
        )
      )
    );
  }
}
