import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function clearSearchResult;
  final String label;
  final String hint;
  Function submit;

  MySearchTextField(
      {required this.textEditingController,
      required this.clearSearchResult,
      required this.hint,
      required this.label,
      required this.submit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TextFormField(
        onFieldSubmitted: (value){
          submit(value);
        },
        controller: textEditingController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            suffixIcon: IconButton(
              onPressed: () {
                clearSearchResult();
              },
              icon: Icon(Icons.clear),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }
}
