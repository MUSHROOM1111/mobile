class MenuDao {
  bool success;
  List<Menu> data;
  String message;

  MenuDao({this.success, this.data, this.message});

  MenuDao.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Menu>();
      json['data'].forEach((v) {
        data.add(new Menu.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Menu {
  int id;
  int restaurantId;
  String name;
  int price;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Menu(
      {this.id,
      this.restaurantId,
      this.name,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
