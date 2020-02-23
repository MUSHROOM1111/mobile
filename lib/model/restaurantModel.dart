class RestaurantDao {
  bool success;
  List<Restaurant> data;
  String message;

  RestaurantDao({this.success, this.data, this.message});

  RestaurantDao.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Restaurant>();
      json['data'].forEach((v) {
        data.add(new Restaurant.fromJson(v));
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

class Restaurant {
  int id;
  String name;
  String address;
  String phonenumber;
  double latValue;
  double lonValue;
  int isActive;
  String image;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Restaurant(
      {this.id,
      this.name,
      this.address,
      this.phonenumber,
      this.latValue,
      this.lonValue,
      this.isActive,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    latValue = json['lat_value'];
    lonValue = json['lon_value'];
    isActive = json['is_active'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    data['lat_value'] = this.latValue;
    data['lon_value'] = this.lonValue;
    data['is_active'] = this.isActive;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
