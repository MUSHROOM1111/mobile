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
