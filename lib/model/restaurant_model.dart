class Restaurant {
  int _id;
  String _name;
  String _address;
  String _phonenumber;
  double _latValue;
  double _lonValue;
  int _isActive;
  String _image;
  int _numRating;
  double _avgRating;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;

  Restaurant(
      {int id,
      String name,
      String address,
      String phonenumber,
      double latValue,
      double lonValue,
      int isActive,
      String image,
      int numRating,
      double avgRating,
      String createdAt,
      String updatedAt,
      String deletedAt}) {
    this._id = id;
    this._name = name;
    this._address = address;
    this._phonenumber = phonenumber;
    this._latValue = latValue;
    this._lonValue = lonValue;
    this._isActive = isActive;
    this._image = image;
    this._numRating = numRating;
    this._avgRating = avgRating;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deletedAt = deletedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get address => _address;
  set address(String address) => _address = address;
  String get phonenumber => _phonenumber;
  set phonenumber(String phonenumber) => _phonenumber = phonenumber;
  double get latValue => _latValue;
  set latValue(double latValue) => _latValue = latValue;
  double get lonValue => _lonValue;
  set lonValue(double lonValue) => _lonValue = lonValue;
  int get isActive => _isActive;
  set isActive(int isActive) => _isActive = isActive;
  String get image => _image;
  set image(String image) => _image = image;
  int get numRating => _numRating;
  set numRating(int numRating) => _numRating = numRating;
  double get avgRating => _avgRating;
  set avgRating(double avgRating) => _avgRating = avgRating;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get deletedAt => _deletedAt;
  set deletedAt(String deletedAt) => _deletedAt = deletedAt;

  Restaurant.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _phonenumber = json['phonenumber'];
    _latValue = json['lat_value'];
    _lonValue = json['lon_value'];
    _isActive = json['is_active'];
    _image = json['image'];
    _numRating = json['num_rating'];
    _avgRating = json['avg_rating'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['address'] = this._address;
    data['phonenumber'] = this._phonenumber;
    data['lat_value'] = this._latValue;
    data['lon_value'] = this._lonValue;
    data['is_active'] = this._isActive;
    data['image'] = this._image;
    data['num_rating'] = this._numRating;
    data['avg_rating'] = this._avgRating;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['deleted_at'] = this._deletedAt;
    return data;
  }
}
