import 'dart:math';

import 'package:flutter/material.dart';

const int XVALUE = 1;
const int OVALUE = 2;
const GameSymbols PLAYER1 = GameSymbols.X;
const GameSymbols PLAYER2 = GameSymbols.O;

enum GameSymbols {
  X("X", Colors.green),
  O("O", Colors.blue),
  TIE("TIE", Colors.yellow),
  EMPTY(" ", Colors.white);

  final String symbol;
  final Color color;

  const GameSymbols(this.symbol, this.color); 
}

bool _check_row(List<GameSymbols> board, int row){
  return board[row * 3 + 0] == board[row * 3 + 1] && board[row * 3 + 1] == board[row * 3 + 2] && board[row * 3 + 0] != GameSymbols.EMPTY;
}
bool _check_column(List<GameSymbols> board, int column){
  return board[0+column] == board[3+column] && board[3+column] == board[6+column] && board[0+column] != GameSymbols.EMPTY;
}

GameSymbols _check_has_winner(List<GameSymbols> board, int checked_positions){
  if (_check_row(board, 0)){
    return board[0];
  }
  if (_check_row(board, 1)){
    return board[3];
  }
  if (_check_row(board, 2)){
    return board[6];
  }
  if (_check_column(board, 0)){
    return board[0];
  }
  if (_check_column(board, 1)){
    return board[1];
  }
  if (_check_column(board, 2)){
    return board[2];
  }
  if ( board[0] == board[4] && board[4] == board[8] && board[0] != GameSymbols.EMPTY){
    return board[0]; 
  }
  if ( board[2] == board[4] && board[4] == board[6] && board[2] != GameSymbols.EMPTY){
    return board[2]; 
  }
  return checked_positions == 9 ?GameSymbols.TIE:GameSymbols.EMPTY;
}

int calcPontuation(GameSymbols winner, GameSymbols calculing_to_player) {
  if (winner == GameSymbols.TIE) return 0;
  return winner == calculing_to_player ? 1 : -1;
}

(int, int) _min(
  List<GameSymbols> board,
  GameSymbols currentPlayer,
  int checkedPositions,
  int alpha,
  int beta
) {
  GameSymbols winner = _check_has_winner(board, checkedPositions);
  if (winner != GameSymbols.EMPTY) {
    return (calcPontuation(winner, currentPlayer == PLAYER1 ? PLAYER2: PLAYER1), -1);
  }

  int bestScore = 9999;
  int bestMove = -1;
  GameSymbols nextPlayer = currentPlayer == GameSymbols.X ? GameSymbols.O : GameSymbols.X;

  for (int i = 0; i < board.length; i++) {
    if (board[i] != GameSymbols.EMPTY) continue;

    board[i] = currentPlayer;
    int score = _max(
      board,
      nextPlayer,
      checkedPositions + 1,
      alpha,
      min(beta, bestScore),
    ).$1;
    board[i] = GameSymbols.EMPTY;

    if (score < bestScore) {
      bestScore = score;
      bestMove = i;
    }

    if (bestScore <= alpha) {
      break;
    }
  }

  return (bestScore, bestMove);
}

(int, int) _max(
  List<GameSymbols> board,
  GameSymbols currentPlayer,
  int checkedPositions,
  int alpha,
  int beta
) {
  GameSymbols winner = _check_has_winner(board, checkedPositions);
  if (winner != GameSymbols.EMPTY) {
    return (calcPontuation(winner, currentPlayer), -1);
  }

  int bestScore = -9999;
  int bestMove = -1;
  GameSymbols nextPlayer = currentPlayer == GameSymbols.X ? GameSymbols.O : GameSymbols.X;

  for (int i = 0; i < board.length; i++) {
    if (board[i] != GameSymbols.EMPTY) continue;

    board[i] = currentPlayer;
    int score = _min(
      board,
      nextPlayer,
      checkedPositions + 1,
      max(alpha, bestScore),
      beta,
    ).$1;
    board[i] = GameSymbols.EMPTY;

    if (score > bestScore) {
      bestScore = score;
      bestMove = i;
    }

    if (bestScore >= beta) {
      break;
    }
  }

  return (bestScore, bestMove);
}
class Game {

  List<GameSymbols> _board = List.filled(9, GameSymbols.EMPTY);
  int _checked_positions = 0;

  GameSymbols _currentPlayer = PLAYER1;

  GameSymbols get(int boardIndex) {
    return _board[boardIndex];
  }

  GameSymbols get_current_player() {
    return _currentPlayer;
  }

  bool take_turn(int board_index){
    if (_board[board_index] != GameSymbols.EMPTY ){
      return false;
    }
    _board[board_index] = _currentPlayer;
    _currentPlayer = _currentPlayer == PLAYER1 ? PLAYER2 : PLAYER1;
    _checked_positions++;
    return true;
  }

  GameSymbols check_has_winner(){
    return _check_has_winner(_board, _checked_positions);
  }

  void reset(){
    _board = List.filled(9, GameSymbols.EMPTY);
    _currentPlayer = GameSymbols.X;
    _checked_positions = 0;
  }

  int calc_better_play(GameSymbols player){
    (int, int) better_move = _max(List.from(_board), player, _checked_positions, -1, 1);
    return better_move.$2;
  }
}
