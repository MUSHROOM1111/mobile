import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rookkie_app_v2/data/menu_data.dart';
import 'package:rookkie_app_v2/model/cart_item.dart';
import 'package:rookkie_app_v2/provider/api_provider.dart';
import 'package:rookkie_app_v2/provider/cart_bloc.dart';
import 'package:rookkie_app_v2/provider/counter_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDetailPage extends StatefulWidget {
  var index_id;
  var name;
  var price;
  var menu_id;

  @override
  MenuDetailPage(@required this.index_id, this.name, this.price, this.menu_id);
  _MenuDetailPageState createState() =>
      _MenuDetailPageState(this.index_id, this.name, this.price, this.menu_id);
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  _MenuDetailPageState(this.index_id, this.name, this.price, this.menu_id);
  var index_id;
  var name;
  var price;
  var menu_id;

  @override
  Widget build(BuildContext context) {
    CounterProvider counterProvider = Provider.of<CounterProvider>(context);

    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    var count = 1;
    ApiProvider apiProvider = ApiProvider();

    // var name = menu[id].name;
    // var price = menu[id].price;
    // counterProvider.reset();

    // Future addMenu(menu_id, quantity) async {
    //   try {
    //     var rs = await apiProvider.addMenu(menu_id, quantity);
    //     print("pass provider");
    //     if (rs.statusCode == 200) {
    //       print("print");
    //       print(rs.body);
    //       // var jsonRes = json.decode(rs.body);
    //       // print("print2");
    //       // print(jsonRes["data"]["id"]);
    //       // int order_id = jsonRes["data"]["id"];
    //       // if (jsonRes["success"]) {
    //       //   print("fucking success");
    //       //   SharedPreferences prefs =
    //       //       await SharedPreferences.getInstance();
    //       //   prefs.setString('order_id', "$order_id");
    //       // }
    //     } else {
    //       // var rs_body = rs.body;
    //       // var jsonRes = json.decode(rs.body);
    //       print('eee');
    //       // print('rs = $rs_body');
    //       // print('jsonRes = $jsonRes');
    //     }
    //   } catch (error) {
    //     print(error);
    //   }
    // }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 40,
                      ),
                      onPressed: () {
                        // counterProvider.reset();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      width: 300,
                      height: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          //color: Colors.black,
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            image: ExactAssetImage(
                                "assets/images/food_delivery_1.png"),
                            // fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "$name ราคา $price บาท",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     "$price",
                //     style: TextStyle(fontSize: 20.0),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "รายละเอียดเพิ่มเติม",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     "$price",
                //     style: TextStyle(fontSize: 20.0),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                          // labelText: content,
                          labelStyle: TextStyle(fontSize: 20.0)),
                      // controller: ctrlMilk,
                    ),
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     "$price",
                //     style: TextStyle(fontSize: 20.0),
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     print('delete');
              //     // counterProvider.delete();
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  print('remove');
                  counterProvider.delete();
                  // bloc.deleteToCart(giftIndex);
                },
              ),
              buildText(counterProvider.counter),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  print('object');
                  counterProvider.increment();

                  // bloc.addToCart(giftIndex);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.orange,
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => RestaurantPage(this.lat, this.lng)));
                  if (counterProvider.counter != 0) {
                    int i = 0;
                    for (i = 0; i < counterProvider.counter; i++) {
                      bloc.addToCart(index_id);
                    }

                    // print("menu_id in menu_detail_page $menu_id");
                    // print("i in menu_detail_page $i");
                    // setState(() {
                    //   addMenu(menu_id, i);
                    // });

                    // menu.add(CartItem(id, name, null, price));
                    // counterProvider.reset();
                    Navigator.of(context).pop();
                  } else {
                    // counterProvider.reset();
                    Navigator.of(context).pop();
                  }
                },
                child: buildButtonText(counterProvider.counter),
              ),
            ],
          )
        ],
      ),
      // floatingActionButton: RaisedButton(
      //   color: Colors.orange,
      //   onPressed: () {
      //     // Navigator.push(
      //     //     context,
      //     //     MaterialPageRoute(
      //     //         builder: (context) => RestaurantPage(this.lat, this.lng)));
      //     if (counterProvider.counter != 0) {
      //       for (int i = 0; i < counterProvider.counter; i++) {
      //         bloc.addToCart(id);
      //       }
      //       // counterProvider.reset();
      //       Navigator.of(context).pop();
      //     } else {
      //       // counterProvider.reset();
      //       Navigator.of(context).pop();
      //     }
      //   },
      //   child: buildButtonText(counterProvider.counter),
      // ),
    );
  }

  buildText(int value) {
    print("Text");
    return Text(
      '$value',
      style: TextStyle(fontSize: 25.0),
    );
  }

  buildButtonText(int value) {
    // var child;
    if (value != 0) {
      return Text(
        'เพิ่มในตะกร้า',
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      );
    } else {
      return Text(
        'ย้อนกลับ',
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      );
    }
  }
}
