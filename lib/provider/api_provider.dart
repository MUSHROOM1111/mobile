import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rookkie_app_v2/model/menuModel.dart';
import 'package:rookkie_app_v2/model/order_dao.dart';
import 'package:rookkie_app_v2/model/restaurantModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  ApiProvider();

  String login = 'http://service.rookkie.com/oauth/token';
  String endPoint = "http://service.rookkie.com/api";

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    return token;
  }

  // Future<http.Response> _doLogin(String username, String password) async {
  //   String _url = '$login';
  //   var body = {
  //     'username': username,
  //     'password': password,
  //     'client_id': '2',
  //     'client_secret': 'tacNc9Ll4lUkD56JMhEKVpdQ9ZVxQCQMhCkPM1Yw',
  //     'grant_type': 'password'
  //   };

  //   return http.post(_url, body: body);
  // }

  Future<http.Response> showUser(String token) async {
    String _url = '$endPoint/users';

    return http
        .get(_url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  Future<http.Response> updateDeviceToken(
      String device_token, int user_id) async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String _url = '$endPoint/users/$user_id/devicetoken';

    print("token auth in update device token = $token");
    var header = {
      'Accept': "application/json",
      'Authorization': "Bearer $token",
    };
    var body = {
      'device_token': "$device_token",
    };
    return http.post(_url, headers: header, body: body);
    // return http.post(_url,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    //     body: body);
  }

  Future<http.Response> ordering(String token, int restaurant_id,
      double customer_lat_value, double customer_lon_value) async {
    String _url = '$endPoint/orders';
    var header = {
      'Accept': "application/json",
      'Authorization': "Bearer $token",
    };
    var body = {
      'status': "ordering",
      'restaurant_id': "$restaurant_id",
      'customer_lat_value': "$customer_lat_value",
      'customer_lon_value': "$customer_lon_value",
    };
    return http.post(_url, headers: header, body: body);
    // return http.post(_url,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    //     body: body);
  }

  Future<http.Response> waitingDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String order_id = prefs.getString('order_id');
    String token = prefs.getString('token');
    String _url = '$endPoint/orders/$order_id';

    var header = {
      'Accept': "application/json",
      'Authorization': "Bearer $token",
    };
    var body = {
      '_method': "put",
      'status': "waiting_driver",
    };
    return http.post(_url, headers: header, body: body);
    // return http.post(_url,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    //     body: body);
  }

  // Future<http.Response> getRestaurant() async {
  //   String _url = '$endPoint/restaurants-open';

  //   return http.get(_url);
  // }
  Future<OrderDao> getOrder(order_id) async {
    print("open get order api");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _url = '$endPoint/orders/$order_id';
    String token = prefs.getString('token');
    // storage.write(key: 'order_id', value: order_id);
    try {
      var response = await http.get(_url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      print(response.body);
      if (response.statusCode == 200) {
        Map map = json.decode(response.body);
        OrderDao msg = OrderDao.fromJson(map);
        print("message = " + msg?.message);
        print("close get order api");
        return msg;
      } else {
        print('error!get order');
      }
    } catch (error) {
      print("error = $error");
    }
    // var response = await http.get(_url,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer 1 $token'});
    // Map map = json.decode(response.body);
    // OrderDao msg = OrderDao.fromJson(map);
    // print("message = " + msg?.message);
    // return msg;
  }

  Future getRestaurant() async {
    print("open get order api");
    String _url = '$endPoint/restaurants-open';
    // var token = await storage.read(key: "token");
    // storage.write(key: 'order_id', value: order_id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      var response = await http.get(_url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      print(response.body);
      if (response.statusCode == 200) {
        Map map = json.decode(response.body);
        RestaurantDao msg = RestaurantDao.fromJson(map);
        print("message = " + msg?.message);
        print("close get order api");
        return msg;
      } else {
        print('error!get order');
      }
    } catch (error) {
      print("error = $error");
    }
  }

  Future getMenu(int restaurant_id) async {
    print("open get menu api");
    String _url = '$endPoint/restaurants/$restaurant_id/menus';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    try {
      var response = await http.get(_url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      print(response.body);
      if (response.statusCode == 200) {
        Map map = json.decode(response.body);
        MenuDao apiData = MenuDao.fromJson(map);
        print("message = " + apiData?.message);
        print("close get menu api");
        return apiData;
      } else {
        print('error!get menu');
      }
    } catch (error) {
      print("error = $error");
    }
  }

  // Future<http.Response> getMenu(int restaurant_id) async {
  //   String _url = '$endPoint/restaurants/$restaurant_id/menus';
  //   print("in getMenu at provider");
  //   // print(_url);
  //   return http.get(_url);
  // }

  Future<http.Response> addMenu(int menu_id, int quantity) async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String order_id = prefs.getString('order_id');
    print("show order id in api provider $order_id");
    // print("token $token");
    String _url = '$endPoint/orders/$order_id/details';

    var header = {
      'Accept': "application/json",
      'Authorization': "Bearer $token",
    };
    var body = {
      'menu_id': "$menu_id",
      'quantity': "$quantity",
    };
    return http.post(_url, headers: header, body: body);
    // return http.post(_url,
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    //     body: body);
  }

  // Future<http.Response> editMenu(int menu_id, int quantity) async {
  //   //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   String order_id = prefs.getString('order_id');
  //   print("show order id in api provider $order_id");
  //   // print("token $token");
  //   String _url = '$endPoint/orders/$order_id/details';

  //   var header = {
  //     'Accept': "application/json",
  //     'Authorization': "Bearer $token",
  //   };
  //   var body = {
  //     'menu_id': "$menu_id",
  //     'quantity': "$quantity",
  //   };
  //   return http.post(_url, headers: header, body: body);
  //   // return http.post(_url,
  //   //     headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
  //   //     body: body);
  // }
}
