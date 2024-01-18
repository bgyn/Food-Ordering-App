import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrdersModel {
  final String orderId;
  final String userId;
  final int orderTotal;
  final String orderStatus;
  final DateTime createdAt;
  final String deliveryMethod;
  final List<String> productId;
  OrdersModel({
    required this.orderId,
    required this.userId,
    required this.orderTotal,
    required this.orderStatus,
    required this.createdAt,
    required this.deliveryMethod,
    required this.productId,
  });

  OrdersModel copyWith({
    String? orderId,
    String? userId,
    int? orderTotal,
    String? orderStatus,
    DateTime? createdAt,
    String? deliveryMethod,
    List<String>? productId,
  }) {
    return OrdersModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      orderTotal: orderTotal ?? this.orderTotal,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'orderTotal': orderTotal,
      'orderStatus': orderStatus,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'deliveryMethod': deliveryMethod,
      'productId': productId,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      orderTotal: map['orderTotal'] as int,
      orderStatus: map['orderStatus'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      deliveryMethod: map['deliveryMethod'] as String,
      productId: List<String>.from(
        (map['productId'] ?? []),
      ),
    );
  }

  @override
  String toString() {
    return 'OrdersModel(orderId: $orderId, userId: $userId, orderTotal: $orderTotal, orderStatus: $orderStatus, createdAt: $createdAt, deliveryMethod: $deliveryMethod, productId: $productId)';
  }

  @override
  bool operator ==(covariant OrdersModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.userId == userId &&
        other.orderTotal == orderTotal &&
        other.orderStatus == orderStatus &&
        other.createdAt == createdAt &&
        other.deliveryMethod == deliveryMethod &&
        listEquals(other.productId, productId);
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        userId.hashCode ^
        orderTotal.hashCode ^
        orderStatus.hashCode ^
        createdAt.hashCode ^
        deliveryMethod.hashCode ^
        productId.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory OrdersModel.fromJson(String source) =>
      OrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
