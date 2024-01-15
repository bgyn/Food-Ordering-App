import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  final String orderId;
  final List<String> productId;
  final String orderStatus;
  final String paymentMethod;
  final String paymentStatus;
  final String deliveryMethod;
  final DateTime timestamp;
  final int amount;
  final String uid;

  OrderModel({
    String? orderId,
    required this.productId,
    required this.orderStatus,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryMethod,
    required this.timestamp,
    required this.amount,
    required this.uid,
  }) : orderId = orderId ?? const Uuid().v4();

  OrderModel copyWith({
    String? orderId,
    List<String>? productId,
    String? orderStatus,
    String? paymentMethod,
    String? paymentStatus,
    String? deliveryMethod,
    DateTime? timestamp,
    int? amount,
    String? uid,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      timestamp: timestamp ?? this.timestamp,
      amount: amount ?? this.amount,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'productId': productId,
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'deliveryMethod' : deliveryMethod,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'amount': amount,
      'uid': uid,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      productId: List<String>.from((map['productId'] as List<String>)),
      orderStatus: map['orderStatus'] as String,
      paymentMethod: map['paymentMethod'] as String,
      paymentStatus: map['paymentStatus'] as String,
      deliveryMethod: map['deliveryMethod'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      amount: map['amount'] as int,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, productId: $productId, orderStatus: $orderStatus, paymentMethod: $paymentMethod, $paymentStatus:paymentStatus,$deliveryMethod : deliveryMethod,timestamp: $timestamp, amount: $amount, uid: $uid)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        listEquals(other.productId, productId) &&
        other.orderStatus == orderStatus &&
        other.paymentMethod == paymentMethod &&
        other.paymentStatus == paymentStatus &&
        other.deliveryMethod == deliveryMethod &&
        other.timestamp == timestamp &&
        other.amount == amount &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        productId.hashCode ^
        orderStatus.hashCode ^
        paymentMethod.hashCode ^
        paymentStatus.hashCode ^
        deliveryMethod.hashCode ^
        timestamp.hashCode ^
        amount.hashCode ^
        uid.hashCode;
  }
}
