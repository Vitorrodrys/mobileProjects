import 'dart:collection';
import 'dart:math';

const int MINEVALUE = -999;
const int HIDDENVALUE = -900;

class GameBoard {

  final int _rows;
  final int _columns;
  final int _mineCount;
  bool revelBombs = false;
  int _reveiledCounter = 0;
  List<List<int>> _board;
  Set<(int, int)> reveiledCeils = HashSet<(int, int)>();
  final Random _random = Random();

  void _populateNeighbours((int, int) mineCord){
    int row = mineCord.$1;
    int column = mineCord.$2;
    for (int i = row - 1; i <= row + 1; i++){
      for (int j = column - 1; j <= column + 1; j++){
        if (i < 0 || i >= _rows || j < 0 || j >= _columns){
          continue;
        }
        if (_board[i][j] == MINEVALUE){
          continue;
        }
        _board[i][j]++;
      }
    }
  }
  GameBoard({required mineCount, required int boardSize})
      : _rows = boardSize,
        _mineCount = mineCount,
        _columns = boardSize,
        _board = List.generate(boardSize, (_) => List.filled(boardSize, 0)){
    if (boardSize < 0 ){
      throw ArgumentError('Board size must be positive');
    }
    (int, int) mineCord;
    for (int i = 0; i < _mineCount; i++) {
      mineCord = (_random.nextInt(boardSize), _random.nextInt(boardSize));
      _board[mineCord.$1][mineCord.$2] = MINEVALUE;
      _populateNeighbours(mineCord);
    }
  }

  int getCeil((int, int) cord){
    if (cord.$1 < 0 || cord.$1 >= _rows || cord.$2 < 0 || cord.$2 >= _columns){
      throw ArgumentError('Invalid coordinates');
    }
    if (revelBombs){
      return _board[cord.$1][cord.$2];
    }
    if (! reveiledCeils.contains(cord)){
      return HIDDENVALUE;
    }
    return _board[cord.$1][cord.$2];
  }

  bool revealCeil((int, int) cord) {
    if (cord.$1 < 0 || cord.$1 >= _rows || cord.$2 < 0 || cord.$2 >= _columns){
      throw ArgumentError('Invalid coordinates');
    }
    reveiledCeils.add(cord);
    int value = _board[cord.$1][cord.$2];
    if (value == MINEVALUE){
      return false;
    }
    _reveiledCounter++;
    return true;
  }

  bool isWin(){
    return _reveiledCounter == (_rows * _columns) - _mineCount;
  }

  void showBombs(){
    revelBombs = true;
  }
  
}