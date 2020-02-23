import 'package:rookkie_app_v2/model/menu_model.dart';
import 'package:rookkie_app_v2/model/restaurant_model.dart';
import 'package:rookkie_app_v2/model/user_model.dart';

class Order {
  int id;
  int customerId;
  int driverId;
  int restaurantId;
  double customerLatValue;
  double customerLonValue;
  double driverLatValue;
  double driverLonValue;
  double restaurantLatValue;
  double restaurantLonValue;
  String status;
  String orderDate;
  String requiredTime;
  String waitingTime;
  String shippingTime;
  String shippedTime;
  int startPrice;
  String totalTime;
  double totalLength;
  int foodPrice;
  int lengthPrice;
  int percentPrice;
  int totalPrice;
  int quantity;
  double discount;
  double driverRating;
  double restaurantRating;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Restaurant restaurant;
  List<Orderdetails> orderdetails;
  User customer;
  User driver;

  Order(
      {this.id,
      this.customerId,
      this.driverId,
      this.restaurantId,
      this.customerLatValue,
      this.customerLonValue,
      this.driverLatValue,
      this.driverLonValue,
      this.restaurantLatValue,
      this.restaurantLonValue,
      this.status,
      this.orderDate,
      this.requiredTime,
      this.waitingTime,
      this.shippingTime,
      this.shippedTime,
      this.startPrice,
      this.totalTime,
      this.totalLength,
      this.foodPrice,
      this.lengthPrice,
      this.percentPrice,
      this.totalPrice,
      this.quantity,
      this.discount,
      this.driverRating,
      this.restaurantRating,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.restaurant,
      this.orderdetails,
      this.customer,
      this.driver});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    driverId = json['driver_id'];
    restaurantId = json['restaurant_id'];
    customerLatValue = json['customer_lat_value'];
    customerLonValue = json['customer_lon_value'];
    driverLatValue = json['driver_lat_value'];
    driverLonValue = json['driver_lon_value'];
    restaurantLatValue = json['restaurant_lat_value'];
    restaurantLonValue = json['restaurant_lon_value'];
    status = json['status'];
    orderDate = json['order_date'];
    requiredTime = json['required_time'];
    waitingTime = json['waiting_time'];
    shippingTime = json['shipping_time'];
    shippedTime = json['shipped_time'];
    startPrice = json['start_price'];
    totalTime = json['total_time'];
    totalLength = json['total_length'];
    foodPrice = json['food_price'];
    lengthPrice = json['length_price'];
    percentPrice = json['percent_price'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    discount = json['discount'];
    driverRating = json['driver_rating'];
    restaurantRating = json['restaurant_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['orderdetails'] != null) {
      orderdetails = new List<Orderdetails>();
      json['orderdetails'].forEach((v) {
        orderdetails.add(new Orderdetails.fromJson(v));
      });
    }
    customer =
        json['customer'] != null ? new User.fromJson(json['customer']) : null;
    driver = json['driver'] != null ? new User.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['driver_id'] = this.driverId;
    data['restaurant_id'] = this.restaurantId;
    data['customer_lat_value'] = this.customerLatValue;
    data['customer_lon_value'] = this.customerLonValue;
    data['driver_lat_value'] = this.driverLatValue;
    data['driver_lon_value'] = this.driverLonValue;
    data['restaurant_lat_value'] = this.restaurantLatValue;
    data['restaurant_lon_value'] = this.restaurantLonValue;
    data['status'] = this.status;
    data['order_date'] = this.orderDate;
    data['required_time'] = this.requiredTime;
    data['waiting_time'] = this.waitingTime;
    data['shipping_time'] = this.shippingTime;
    data['shipped_time'] = this.shippedTime;
    data['start_price'] = this.startPrice;
    data['total_time'] = this.totalTime;
    data['total_length'] = this.totalLength;
    data['food_price'] = this.foodPrice;
    data['length_price'] = this.lengthPrice;
    data['percent_price'] = this.percentPrice;
    data['total_price'] = this.totalPrice;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['driver_rating'] = this.driverRating;
    data['restaurant_rating'] = this.restaurantRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    if (this.orderdetails != null) {
      data['orderdetails'] = this.orderdetails.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    return data;
  }
}

class Orderdetails {
  int id;
  int menuId;
  int orderId;
  int unitPrice;
  int quantity;
  int totalPrice;
  int discount;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Menu menu;

  Orderdetails(
      {this.id,
      this.menuId,
      this.orderId,
      this.unitPrice,
      this.quantity,
      this.totalPrice,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.menu});

  Orderdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    orderId = json['order_id'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['order_id'] = this.orderId;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.menu != null) {
      data['menu'] = this.menu.toJson();
    }
    return data;
  }
}
