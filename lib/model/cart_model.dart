import 'package:flutter/foundation.dart';

class CartModel {
  final String cid;
  final String uid;
  final List<CartItem> item;
  CartModel({
    required this.cid,
    required this.uid,
    required this.item,
  });

  CartModel copyWith({
    String? cid,
    String? uid,
    List<CartItem>? item,
  }) {
    return CartModel(
      cid: cid ?? this.cid,
      uid: uid ?? this.uid,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'uid': uid,
      'item': item.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cid: map['cid'] as String,
      uid: map['uid'] as String,
      item: List<CartItem>.from(
        (map['item'] ?? []).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'CartModel(cid: $cid, uid: $uid, item: $item)';

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.cid == cid && other.uid == uid && listEquals(other.item, item);
  }

  @override
  int get hashCode => cid.hashCode ^ uid.hashCode ^ item.hashCode;
}

class CartItem {
  final String pid;
  final int price;
  final int quantity;
  CartItem({
    required this.pid,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    String? pid,
    int? price,
    int? quantity,
  }) {
    return CartItem(
      pid: pid ?? this.pid,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      pid: map['pid'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }

  @override
  String toString() =>
      'CartItem(pid: $pid, price: $price, quantity: $quantity)';

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.pid == pid &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => pid.hashCode ^ price.hashCode ^ quantity.hashCode;
}
