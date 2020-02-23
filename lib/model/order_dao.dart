import 'package:rookkie_app_v2/model/order_model.dart';

class OrderDao {
  bool success;
  Order data;
  String message;

  OrderDao({this.success, this.data, this.message});

  OrderDao.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Order.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
