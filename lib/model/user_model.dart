import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String address;
  final String phoneNo;
  String? profilePic;
  final List<String> cart;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNo,
    this.profilePic,
    required this.cart,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? address,
    String? phoneNo,
    String? profilePic,
    List<String>? cart,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNo: phoneNo ?? this.phoneNo,
      profilePic: profilePic ?? this.profilePic,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'address': address,
      'phoneNo': phoneNo,
      'profilePic': profilePic,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        address: map['address'] ?? '',
        phoneNo: map['phoneNo'] ?? '',
        profilePic: map['profilePic'],
        cart: List<String>.from(
          (map['cart'] ?? []),
        ));
  }

  @override
  String toString() {
    return 'UserModle(uid: $uid, name: $name, email: $email, address: $address, phoneNo: $phoneNo, profilePic: $profilePic, cart: $cart)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.address == address &&
        other.phoneNo == phoneNo &&
        other.profilePic == profilePic &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        phoneNo.hashCode ^
        profilePic.hashCode ^
        cart.hashCode;
  }
}
