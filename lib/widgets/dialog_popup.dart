import 'package:flutter/material.dart';

class DialogPopUp extends StatelessWidget {
  const DialogPopUp({
    Key key,
    @required this.context,
    this.title,
    this.content,
    this.button,
  }) : super(key: key);

  final String title;
  final String content;
  final String button;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title ?? ""),
      content: new Text(content ?? ""),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text(button ?? "ปิด"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
