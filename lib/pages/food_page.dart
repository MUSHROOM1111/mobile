import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สั่งอาหาร'),
        // actions: <Widget>[
        //   RaisedButton(
        //     color: Colors.blue,
        //     onPressed: () {},
        //     child: Text('บันทึก'),
        //   )
        // ],
      ),
    );
  }
}