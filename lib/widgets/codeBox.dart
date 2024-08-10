import 'package:flutter/material.dart';

class CodeBox extends StatelessWidget {
  final int moveCount;
  final FocusNode focusNode;
  final Function(String) onTextChanged;

  const CodeBox({
    required Key key,
    required this.moveCount,
    required this.focusNode,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(4),
      transform: Matrix4.translationValues(50.0, moveCount * 0.0, 50.0),
      child: Material(
        elevation: 3.0,
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          maxLength: 1,
          decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            border: InputBorder.none,
            counterText: '',
          ),
          focusNode: focusNode,
          onChanged: onTextChanged,
        ),
      ),
    );
  }
}