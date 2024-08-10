import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String label;
  const CustomTextField({
    Key? key,
    this.textEditingController,
    this.label = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.check,
            color: Colors.grey,
          ),
          label: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffB81736),
            ),
          )),
    );
  }
}
