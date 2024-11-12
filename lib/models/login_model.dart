class LoginModel {
  bool? ok;
  int? statusCode;
  String? message;
  Data? data;

  LoginModel({this.ok, this.statusCode, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
    'ok': ok,
    'statusCode': statusCode,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'user': user?.toJson(),
  };
}

class User {
  String? id;
  String? name;
  String? email;
  String? address;
  dynamic age;
  String? gender;
  double? height;
  String? image;
  double? weight;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.age,
    this.gender,
    this.height,
    this.image,
    this.weight,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    age = json['age'] != null ? int.tryParse(json['age'].toString()) : null;
    gender = json['gender'];
    height = json['height'] != null ? double.tryParse(json['height'].toString()) : null;
    image = json['image'];
    weight = json['weight'] != null ? double.tryParse(json['weight'].toString()) : null;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'address': address,
    'age': age,
    'gender': gender,
    'height': height,
    'image': image,
    'weight': weight,
  };
}
