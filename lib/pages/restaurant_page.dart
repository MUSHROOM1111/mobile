import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rookkie_app_v2/model/restaurantModel.dart';
import 'package:rookkie_app_v2/pages/menu_page.dart';
import 'package:rookkie_app_v2/provider/api_provider.dart';

class RestaurantPage extends StatefulWidget {
  double lat;
  double lng;

  @override
  RestaurantPage(this.lat, this.lng);
  _RestaurantPageState createState() =>
      _RestaurantPageState(this.lat, this.lng);
}

class _RestaurantPageState extends State<RestaurantPage> {
  _RestaurantPageState(this.lat, this.lng);
  double lat;
  double lng;
  // List restaurants_list = [];
  bool isLoading = false;
  int startLength = 10;

  ApiProvider apiProvider = ApiProvider();

  var restaurants;
  List restaurants_list;
  getRestaurant() async {
    setState(() {
      isLoading = false;
    });
    print("open restaurant function in restaurant page");
    restaurants = await apiProvider.getRestaurant();
    if (restaurants != null) {
      print("restaurants = $restaurants");
      print(restaurants.data.toString());
      setState(() {
        restaurants_list = restaurants.data;
        startLength = restaurants_list.length;
        isLoading = true;
      });
      print("close restaurant function in restaurant page");
    } else {
      print('error!function get restaurant');
    }
  }

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

    getRestaurant();
    // print("lat lng");
    // print(lat);
    // print(lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกร้านอาหาร'),
      ),
      body: _loadingAction(
        context,
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            // var restaurant = restaurants_list[index];
            // int id = restaurant['id'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ListTile(
                  title: Text(restaurants_list[index].name.toString()),
                  // subtitle: Text("$id"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuPage(
                            restaurants_list[index].id,
                            restaurants_list[index].name.toString(),
                            lat,
                            lng),
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
    );
  }
}
