import 'dart:convert';

import '../public/constants.dart';

class UserModel {
  final String id;
  final String photo;
  final String blurHash;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String type;
  final String tokenFCM;
  final String token;
  final List<String>? favorites;

  UserModel({
    required this.id,
    required this.photo,
    required this.blurHash,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.type,
    required this.tokenFCM,
    required this.token,
    this.favorites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'blurHash': blurHash,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'type': type,
      'tokenFCM': tokenFCM,
      'token': token,
      'favorites': favorites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      photo: map['photo'] == AppConstants.urlImageDefaultPreson ||
              map['photo'] == null ||
              map['photo'] == ''
          ? AppConstants.urlImageDefaultPreson
          : map['photo'],
          // map['photo'].toString().contains('http')
          //     ? map['photo']
          //     : (Application.imageUrl + map['photo']),
      blurHash: map['blurHash'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      tokenFCM: map['tokenFCM'] ?? '',
      token: map['token'] ?? '',
      favorites: List<String>.from(map['favorites']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? photo,
    String? blurHash,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? type,
    String? tokenFCM,
    String? token,
    List<String>? favorites,
  }) {
    return UserModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      blurHash: blurHash ?? this.blurHash,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      tokenFCM: tokenFCM ?? this.tokenFCM,
      token: token ?? this.token,
      favorites: favorites ?? this.favorites,
    );
  }
}
