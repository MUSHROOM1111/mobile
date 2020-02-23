import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:rookkie_app_v2/data/menu_data.dart';
import 'package:rookkie_app_v2/model/menuModel.dart';
import 'package:rookkie_app_v2/pages/waiting_driver_page.dart';
import 'package:rookkie_app_v2/provider/api_provider.dart';
import 'package:rookkie_app_v2/provider/cart_bloc.dart';

class CartPage extends StatefulWidget {
  var restaurant_id;
  CartPage(this.restaurant_id);
  @override
  _CartPageState createState() => _CartPageState(this.restaurant_id);
}

class _CartPageState extends State<CartPage> {
  var restaurant_id;
  _CartPageState(this.restaurant_id);
  ApiProvider apiProvider = ApiProvider();
  // List<Menu> menus;
  List<Menu> data;
  List select_menu = [];
  List select_quantity;
  // int startLength = 10;

  // Future getMenu(id) async {
  //   print("in future get menu");
  //   try {
  //     var rs = await apiProvider.getMenu(id);
  //     print("rs.body = ");
  //     print(rs.body);
  //     if (rs.statusCode == 200) {
  //       // print(rs.body);
  //       var jsonRes = json.decode(rs.body);
  //       if (jsonRes['success']) {
  //         setState(() {
  //           // menus = jsonRes['data'];
  //           print("data menus");
  //           print(jsonRes['data']);
  //           print(jsonRes['data'].length);

  //           data = new List<Menu>();
  //           jsonRes['data'].forEach((v) {
  //             data.add(new Menu.fromJson(v));
  //           });

  //           menus = data;
  //           print("Show all $menus");
  //           print(menus[0].id);
  //         });
  //       } else {
  //         print('object error');
  //       }
  //     } else {
  //       print('eee');
  //     }
  //   } catch (error) {
  //     print("error = $error");
  //   }
  //   print("close future get menu");
  // }
  var menus;
  List menus_list;
  int startLength;
  getMenu(restaurant_id) async {
    setState(() {
      isLoading = false;
    });
    print("open restaurant function in restaurant page");
    menus = await apiProvider.getMenu(restaurant_id);
    if (menus != null) {
      print("menus = $menus");
      print(menus.data.toString());
      setState(() {
        menus_list = menus.data;
        startLength = menus_list.length;
        isLoading = true;
      });
      print("close restaurant function in restaurant page");
    } else {
      print('error!function get restaurant');
    }
  }

  Future addMenu(menu_id, quantity) async {
    try {
      var rs = await apiProvider.addMenu(menu_id, quantity);
      print(rs.body);
      print("pass provider");
      if (rs.statusCode == 200) {
        print("print");
        print(rs.body);
        // var jsonRes = json.decode(rs.body);
        // print("print2");
        // print(jsonRes["data"]["id"]);
        // int order_id = jsonRes["data"]["id"];
        // if (jsonRes["success"]) {
        //   print("fucking success");
        //   SharedPreferences prefs =
        //       await SharedPreferences.getInstance();
        //   prefs.setString('order_id', "$order_id");
        // }
      } else {
        // var rs_body = rs.body;
        // var jsonRes = json.decode(rs.body);
        print('eee');
        // print('rs = $rs_body');
        // print('jsonRes = $jsonRes');
      }
    } catch (error) {
      print(error);
    }
  }

  bool isLoading;
  Widget _loadingAction(BuildContext context, Widget child_import) {
    var child;
    if (isLoading) {
      child = child_import;
    } else {
      child = Center(
        // padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      );
    }
    return new Container(child: child);
  }

  Future waitingDriver() async {
    try {
      var rs = await apiProvider.waitingDriver();
      print(rs.body);
      print("print waitingDriver1");
      if (rs.statusCode == 200) {
        print("print waitingDriver2");
        print(rs.body);
        var jsonRes = json.decode(rs.body);
        print("print2");
        print(jsonRes["data"]["id"]);
        if (jsonRes["success"]) {
          print("fucking success");
        }

        // if (jsonRes['success']) {
        //   setState(() {
        //     menus = jsonRes['data'];
        //   });
        // } else {
        //   print('object error');
        // }
      } else {
        print('eee');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    print("show id");
    // restaurant_id = id;
    // print(this.id);
    getMenu(restaurant_id);
    // print(rs.body);
    print("menus $menus");
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    setState(() {
      startLength = cart.length;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("ตระกร้า"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print(cart.keys.toList());
              int cartindex = cart.keys.toList().length;
              print("show length $cartindex");
              bloc.clearAll(cart.keys.toList());
              // for (int i = 0; i < cart.keys.toList().length; i++) {
              //   int cartindex = cart.keys.toList()[i];
              //   print("check cart");
              //   print(cartindex);
              //   print("i first $i");
              //   // bloc.clear(cartindex);
              //   print("i last $i");
              // }
              // bloc.clear(cart.keys.toList());
            },
          ),
        ],
      ),
      body: _loadingAction(
        context,
        ListView.builder(
          itemCount: startLength,
          itemBuilder: (context, index) {
            // var menu = menus[index];
            // int menuIndex = cart.keys.toList()[index];
            // print("menu11");
            // print(menu);

            print("in body at cart page");
            print("bloc $bloc");
            print("cart $cart");

            print("index = $index");
            int giftIndex = cart.keys.toList()[index];
            int count = cart[giftIndex];
            print("id and name");
            print(menus_list[giftIndex].id);
            print(menus_list[giftIndex].name);

            int menu_id = menus_list[giftIndex].id;

            select_menu.add(menu_id);
            select_quantity = cart.values.toList();

            print(cart.keys.toList()[index]);
            print(cart.values.toList()[index]);
            print("giftIndex $giftIndex");
            print(cart.keys.toList());
            print(cart.values.toList());
            print("select");
            print(select_menu);
            print(select_quantity);

            return ListTile(
              // leading: Container(
              //   height: 70,
              //   width: 70,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage("assets/${giftIndex + 1}.jpg"),
              //       fit: BoxFit.fitWidth,
              //     ),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              // ),
              title: Text(menus_list[giftIndex].name),
              // title: Text('Item Count: $count'),
              // trailing: RaisedButton(
              //   child: Text('Clear'),
              //   color: Theme.of(context).buttonColor,
              //   elevation: 1.0,
              //   splashColor: Colors.blueGrey,
              //   onPressed: () {
              //     bloc.clear(giftIndex);
              //   },
              // ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      bloc.clear(giftIndex);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      bloc.deleteToCart(giftIndex);
                    },
                  ),
                  Text("$count"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      bloc.addToCart(giftIndex);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: MaterialButton(
          child: Text(
            "ยืนยัน ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            setState(() {
              // addMenu(menu_id, i);
              for (int i = 0; i < select_menu.length; i++) {
                // print(select_menu[i]);
                // print(select_quantity[i]);
                addMenu(select_menu[i], select_quantity[i]);
              }
              print("waiting?");
              waitingDriver();
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WaitingDriverPage(),
              ),
            );
            // showDialog(
            //     context: context,
            //     builder: (BuildContext) {
            //       return new SimpleDialog(
            //         title: const Text(
            //           'ยืนยันคำสั่งซื้อ',
            //           style: TextStyle(
            //               fontSize: 20.0, fontWeight: FontWeight.bold),
            //         ),
            //         children: <Widget>[
            //           new SimpleDialogOption(
            //             onPressed: () {
            //               // Navigator.pop(context);
            //               setState(() {
            //                 // addMenu(menu_id, i);
            //                 for (int i = 0; i < select_menu.length; i++) {
            //                   // print(select_menu[i]);
            //                   // print(select_quantity[i]);
            //                   addMenu(select_menu[i], select_quantity[i]);
            //                 }
            //                 print("waiting?");
            //                 waitingDriver();
            //               });
            //             },
            //             child: const Text(
            //               'ตกลง',
            //               style: TextStyle(fontSize: 20.0, color: Colors.black),
            //             ),
            //           ),
            //           new SimpleDialogOption(
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //             child: const Text(
            //               'ยกเลิก',
            //               style: TextStyle(fontSize: 20.0, color: Colors.red),
            //             ),
            //           )
            //         ],
            //       );
            //     });
          },
          elevation: 4.0,
          minWidth: double.infinity,
          height: 48.0,
          color: Colors.orange,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
