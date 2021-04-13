import 'package:flutter/material.dart';

class FieldAuth extends StatelessWidget {
  final String label;
  final EdgeInsets margin;
  final TextInputType type;
  final FocusNode fieldFocusNode, nextFieldFocusNode;
  final bool isPassword;
  final Function(String) onChange;
  final bool error;
  final String errorText;
  final TextEditingController controller;

  FieldAuth({
    Key key,
    @required this.label,
    this.margin,
    this.type,
    @required this.fieldFocusNode,
    this.nextFieldFocusNode,
    this.isPassword = false,
    this.onChange,
    this.error = false,
    this.errorText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: fieldFocusNode,
        onChanged: onChange,
        onFieldSubmitted: (_) {
          if (nextFieldFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFieldFocusNode);
          }
        },
        keyboardType: type,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: fieldFocusNode.hasFocus
                ? Theme.of(context).accentColor
                : Theme.of(context).disabledColor,
          ),
          errorText: error ? errorText : null,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
