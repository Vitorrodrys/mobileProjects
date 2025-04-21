import 'package:flutter/material.dart';



class Ceil extends StatelessWidget {

  const Ceil({super.key, required VoidCallback onTap, required String content})
    : _onTap = onTap,
      _content = content;
  final VoidCallback _onTap;
  final String _content;

  Color ceilColor(String content){
    switch (content){
      case "💣":
        return Colors.red;
      case "":
        return Colors.grey[300]!;
      default:
        return Colors.blue;
    }
  }
  @override
  Widget build(BuildContext context) {
    print("rebuilding Ceil screen");
    bool isHidden = _content == "";
    Color color = ceilColor(_content);
    return GestureDetector(
      onTap: isHidden ? _onTap : null,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            _content,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
