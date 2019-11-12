import 'package:flutter/material.dart';

class FullButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  FullButton({
    @required this.text,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: 50.0),
        child: RaisedButton(
          color: this.color ?? Theme.of(context).primaryColor,
          onPressed: this.onPressed ?? (){},
          textColor: Colors.white,
          child: Text(this.text, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}