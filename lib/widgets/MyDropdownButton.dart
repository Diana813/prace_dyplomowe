import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prace_dyplomowe/utils/MyColors.dart';

class MyDropdownButton extends StatelessWidget {
  List<String> tables;
  String dropdownValue;
  Function onChange;

  MyDropdownButton(
      {required this.tables,
      required this.dropdownValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: MyColors.green,
      ),
      onChanged: (String? newValue) {
        onChange(newValue);
      },
      items: tables.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
