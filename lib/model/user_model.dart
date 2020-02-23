class User {
  int _id;
  String _name;
  String _email;
  String _emailVerifiedAt;
  String _type;
  String _image;
  int _isActiveAccount;
  int _workStatus;
  String _fcmToken;
  int _numRating;
  int _avgRating;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;
  Userinfo _userinfo;

  User(
      {int id,
      String name,
      String email,
      String emailVerifiedAt,
      String type,
      String image,
      int isActiveAccount,
      int workStatus,
      String fcmToken,
      int numRating,
      int avgRating,
      String createdAt,
      String updatedAt,
      String deletedAt,
      Userinfo userinfo}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._emailVerifiedAt = emailVerifiedAt;
    this._type = type;
    this._image = image;
    this._isActiveAccount = isActiveAccount;
    this._workStatus = workStatus;
    this._fcmToken = fcmToken;
    this._numRating = numRating;
    this._avgRating = avgRating;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deletedAt = deletedAt;
    this._userinfo = userinfo;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  String get emailVerifiedAt => _emailVerifiedAt;
  set emailVerifiedAt(String emailVerifiedAt) =>
      _emailVerifiedAt = emailVerifiedAt;
  String get type => _type;
  set type(String type) => _type = type;
  String get image => _image;
  set image(String image) => _image = image;
  int get isActiveAccount => _isActiveAccount;
  set isActiveAccount(int isActiveAccount) =>
      _isActiveAccount = isActiveAccount;
  int get workStatus => _workStatus;
  set workStatus(int workStatus) => _workStatus = workStatus;
  String get fcmToken => _fcmToken;
  set fcmToken(String fcmToken) => _fcmToken = fcmToken;
  int get numRating => _numRating;
  set numRating(int numRating) => _numRating = numRating;
  int get avgRating => _avgRating;
  set avgRating(int avgRating) => _avgRating = avgRating;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get deletedAt => _deletedAt;
  set deletedAt(String deletedAt) => _deletedAt = deletedAt;
  Userinfo get userinfo => _userinfo;
  set userinfo(Userinfo userinfo) => _userinfo = userinfo;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _type = json['type'];
    _image = json['image'];
    _isActiveAccount = json['is_active_account'];
    _workStatus = json['work_status'];
    _fcmToken = json['fcm_token'];
    _numRating = json['num_rating'];
    _avgRating = json['avg_rating'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['type'] = this._type;
    data['image'] = this._image;
    data['is_active_account'] = this._isActiveAccount;
    data['work_status'] = this._workStatus;
    data['fcm_token'] = this._fcmToken;
    data['num_rating'] = this._numRating;
    data['avg_rating'] = this._avgRating;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['deleted_at'] = this._deletedAt;
    if (this._userinfo != null) {
      data['userinfo'] = this._userinfo.toJson();
    }
    return data;
  }
}

class Userinfo {
  int _id;
  int _userId;
  String _firstname;
  String _lastname;
  String _idNumber;
  String _sex;
  String _dob;
  String _address;
  String _address2;
  String _subdistrict;
  String _district;
  String _province;
  String _zipcode;
  String _phonenumber;
  double _latValue;
  double _lonValue;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;

  Userinfo(
      {int id,
      int userId,
      String firstname,
      String lastname,
      String idNumber,
      String sex,
      String dob,
      String address,
      String address2,
      String subdistrict,
      String district,
      String province,
      String zipcode,
      String phonenumber,
      double latValue,
      double lonValue,
      String createdAt,
      String updatedAt,
      String deletedAt}) {
    this._id = id;
    this._userId = userId;
    this._firstname = firstname;
    this._lastname = lastname;
    this._idNumber = idNumber;
    this._sex = sex;
    this._dob = dob;
    this._address = address;
    this._address2 = address2;
    this._subdistrict = subdistrict;
    this._district = district;
    this._province = province;
    this._zipcode = zipcode;
    this._phonenumber = phonenumber;
    this._latValue = latValue;
    this._lonValue = lonValue;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deletedAt = deletedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get firstname => _firstname;
  set firstname(String firstname) => _firstname = firstname;
  String get lastname => _lastname;
  set lastname(String lastname) => _lastname = lastname;
  String get idNumber => _idNumber;
  set idNumber(String idNumber) => _idNumber = idNumber;
  String get sex => _sex;
  set sex(String sex) => _sex = sex;
  String get dob => _dob;
  set dob(String dob) => _dob = dob;
  String get address => _address;
  set address(String address) => _address = address;
  String get address2 => _address2;
  set address2(String address2) => _address2 = address2;
  String get subdistrict => _subdistrict;
  set subdistrict(String subdistrict) => _subdistrict = subdistrict;
  String get district => _district;
  set district(String district) => _district = district;
  String get province => _province;
  set province(String province) => _province = province;
  String get zipcode => _zipcode;
  set zipcode(String zipcode) => _zipcode = zipcode;
  String get phonenumber => _phonenumber;
  set phonenumber(String phonenumber) => _phonenumber = phonenumber;
  double get latValue => _latValue;
  set latValue(double latValue) => _latValue = latValue;
  double get lonValue => _lonValue;
  set lonValue(double lonValue) => _lonValue = lonValue;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get deletedAt => _deletedAt;
  set deletedAt(String deletedAt) => _deletedAt = deletedAt;

  Userinfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _idNumber = json['id_number'];
    _sex = json['sex'];
    _dob = json['dob'];
    _address = json['address'];
    _address2 = json['address2'];
    _subdistrict = json['subdistrict'];
    _district = json['district'];
    _province = json['province'];
    _zipcode = json['zipcode'];
    _phonenumber = json['phonenumber'];
    _latValue = json['lat_value'];
    _lonValue = json['lon_value'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['firstname'] = this._firstname;
    data['lastname'] = this._lastname;
    data['id_number'] = this._idNumber;
    data['sex'] = this._sex;
    data['dob'] = this._dob;
    data['address'] = this._address;
    data['address2'] = this._address2;
    data['subdistrict'] = this._subdistrict;
    data['district'] = this._district;
    data['province'] = this._province;
    data['zipcode'] = this._zipcode;
    data['phonenumber'] = this._phonenumber;
    data['lat_value'] = this._latValue;
    data['lon_value'] = this._lonValue;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['deleted_at'] = this._deletedAt;
    return data;
  }
}
