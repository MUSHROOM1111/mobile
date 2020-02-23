import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:rookkie_app_v2/data/menu_data.dart';
import 'package:rookkie_app_v2/pages/cart_page.dart';
import 'package:rookkie_app_v2/pages/menu_detail_page.dart';
import 'package:rookkie_app_v2/provider/api_provider.dart';
import 'package:rookkie_app_v2/provider/cart_bloc.dart';
import 'package:rookkie_app_v2/provider/counter_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  var id;
  var name;
  double lat;
  double lng;
  MenuPage(this.id, this.name, this.lat, this.lng);
  @override
  _MenuPageState createState() =>
      _MenuPageState(this.id, this.name, this.lat, this.lng);
}

class _MenuPageState extends State<MenuPage> {
  var id;
  var name;
  double lat;
  double lng;

  _MenuPageState(this.id, this.name, this.lat, this.lng);

  int restaurant_id;

  ApiProvider apiProvider = ApiProvider();
  // List menus = [];
  // Future getMenu(id) async {
  //   try {
  //     var rs = await apiProvider.getMenu(id);
  //     // print(rs.body);
  //     if (rs.statusCode == 200) {
  //       // print(rs.body);
  //       var jsonRes = json.decode(rs.body);
  //       if (jsonRes['success']) {
  //         setState(() {
  //           menus = jsonRes['data'];
  //         });
  //       } else {
  //         print('object error');
  //       }
  //     } else {
  //       print('eee');
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future ordering() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      var rs = await apiProvider.ordering(token, restaurant_id, lat, lng);
      print("restaurant id = $restaurant_id");
      print(rs.body);
      // print(lat);
      // print(lng);
      if (rs.statusCode == 200) {
        print("print");
        print(rs.body);
        var jsonRes = json.decode(rs.body);
        print("print2");
        print(jsonRes["data"]["id"]);
        int order_id = jsonRes["data"]["id"];
        if (jsonRes["success"]) {
          print("fucking success");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('order_id', "$order_id");
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

  var menus;
  List menus_list;
  int startLength;
  getMenu() async {
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

  @override
  void initState() {
    super.initState();
    print("show id");
    restaurant_id = id;
    print(this.id);
    print(restaurant_id);
    getMenu();
    print("ordering");
    ordering();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    CounterProvider counterProvider = Provider.of<CounterProvider>(context);

    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("$name"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(id),
                    ),
                  );
                },
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                    new Positioned(
                      child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red[700]),
                          new Positioned(
                            top: 3.0,
                            right: 7,
                            child: new Center(
                              child: new Text(
                                '$totalCount',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: _loadingAction(
        context,
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            // var menu = menus[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  // image: new DecorationImage(
                  //   image:
                  //       ExactAssetImage('assets/images/cow_8.png'),
                  //   // fit: BoxFit.scaleDown,
                  //   alignment: Alignment.centerLeft,
                  // )
                ),
                child: ListTile(
                  // leading: ConstrainedBox(
                  //   constraints: BoxConstraints(
                  //     minWidth: 44,
                  //     minHeight: 44,
                  //     maxWidth: 64,
                  //     maxHeight: 64,
                  //   ),
                  //   child: Image.asset(milk_list[index].image,
                  //       fit: BoxFit.contain),
                  // ),
                  // leading: CircleAvatar(
                  //   radius: 30.0,
                  //   backgroundImage: AssetImage(menu[index].image),
                  //   backgroundColor: Colors.transparent,
                  // ),
                  title: Text(menus_list[index].name.toString()),
                  // subtitle: Text('รหัสโค : ' + menu[index].code),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    print('click');
                    // bloc.addToCart(index);
                    counterProvider.reset();
                    print("index $index");
                    print(menus_list[index].price.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuDetailPage(
                          index,
                          menus_list[index].name.toString(),
                          menus_list[index].price,
                          menus_list[index].id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          //     separatorBuilder: (context, index) => Divider(),
          itemCount: startLength,
        ),
      ),
      // body: ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     // var menu = menus[index];

      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(5.0),
      //           // image: new DecorationImage(
      //           //   image:
      //           //       ExactAssetImage('assets/images/cow_8.png'),
      //           //   // fit: BoxFit.scaleDown,
      //           //   alignment: Alignment.centerLeft,
      //           // )
      //         ),
      //         child: ListTile(
      //           // leading: ConstrainedBox(
      //           //   constraints: BoxConstraints(
      //           //     minWidth: 44,
      //           //     minHeight: 44,
      //           //     maxWidth: 64,
      //           //     maxHeight: 64,
      //           //   ),
      //           //   child: Image.asset(milk_list[index].image,
      //           //       fit: BoxFit.contain),
      //           // ),
      //           // leading: CircleAvatar(
      //           //   radius: 30.0,
      //           //   backgroundImage: AssetImage(menu[index].image),
      //           //   backgroundColor: Colors.transparent,
      //           // ),
      //           title: Text(menus_list[index].name.toString()),
      //           // subtitle: Text('รหัสโค : ' + menu[index].code),
      //           trailing: Icon(Icons.add),
      //           onTap: () {
      //             print('click');
      //             // bloc.addToCart(index);
      //             counterProvider.reset();
      //             print("index $index");
      //             // Navigator.push(
      //             //   context,
      //             //   MaterialPageRoute(
      //             //     builder: (context) => MenuDetailPage(
      //             //       index,
      //             //       menu["name"],
      //             //       menu["price"],
      //             //       menu["id"],
      //             //     ),
      //             //   ),
      //             // );

      //             // flutter defined function
      //             // showDialog(
      //             //   context: context,
      //             //   builder: (BuildContext context) {
      //             //     // return object of type Dialog
      //             //     return AlertDialog(
      //             //       title: new Text("Alert Dialog title"),
      //             //       content: new Text("Alert Dialog body"),
      //             //       actions: <Widget>[
      //             //         // usually buttons at the bottom of the dialog
      //             //         new FlatButton(
      //             //           child: new Text("Close"),
      //             //           onPressed: () {
      //             //             Navigator.of(context).pop();
      //             //           },
      //             //         ),
      //             //       ],
      //             //     );
      //             //     // return Dialog(
      //             //     //   elevation: 0.0,
      //             //     //   backgroundColor: Colors.transparent,
      //             //     //   child: Container(
      //             //     //     width: MediaQuery.of(context).size.width,
      //             //     //     height: MediaQuery.of(context).size.height,
      //             //     //     color: Colors.red,
      //             //     //   ),
      //             //     // );
      //             //   },
      //             // );
      //           },
      //         ),
      //       ),
      //     );
      //   },
      //   //     separatorBuilder: (context, index) => Divider(),
      //   itemCount: startLength,
      // ),
    );
  }
}
