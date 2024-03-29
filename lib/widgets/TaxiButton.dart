import 'package:flutter/material.dart';

class TaxiButton extends StatelessWidget {

  final String title;
  final Color color;
  final Function onPressed;

  TaxiButton({this.title, this.onPressed, this.color});


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25)
      ),
      textColor: Colors.black,
      color: color,
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold', color: Colors.black),
          ),
        ),
      ),
    );
  }
}