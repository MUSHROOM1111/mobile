import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageBox extends StatefulWidget {
  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'ข้อความ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: new Icon(FontAwesomeIcons.trashAlt),
          )
        ],
      ),
    );
  }
}
