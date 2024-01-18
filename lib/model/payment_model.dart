class PaymentModel {
  final String paymentId;
  final String orderId;
  final String paymentMethod;
  final int amount;
  final String status;
  PaymentModel({
    required this.paymentId,
    required this.orderId,
    required this.paymentMethod,
    required this.amount,
    required this.status,
  });

  PaymentModel copyWith({
    String? paymentId,
    String? orderId,
    String? paymentMethod,
    int? amount,
    String? status,
  }) {
    return PaymentModel(
      paymentId: paymentId ?? this.paymentId,
      orderId: orderId ?? this.orderId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payment_id': paymentId,
      'order_id': orderId,
      'payment_method': paymentMethod,
      'amount': amount,
      'status': status,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      paymentId: map['payment_id'] as String,
      orderId: map['order_id'] as String,
      paymentMethod: map['payment_method'] as String,
      amount: map['amount'] as int,
      status: map['status'] as String,
    );
  }

  @override
  String toString() {
    return 'PaymentModel(payment_id: $paymentId, order_id: $orderId, payment_method: $paymentMethod, amount: $amount, status: $status)';
  }

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.paymentId == paymentId &&
      other.orderId == orderId &&
      other.paymentMethod == paymentMethod &&
      other.amount == amount &&
      other.status == status;
  }

  @override
  int get hashCode {
    return paymentId.hashCode ^
      orderId.hashCode ^
      paymentMethod.hashCode ^
      amount.hashCode ^
      status.hashCode;
  }
}
