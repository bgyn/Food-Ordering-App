class PaymentStatus {
  static const String pending = "pending";
  static const String processing = "processing";
  static const String authorized = "authorized";
  static const String completed = "completed";
  static const String failed = "failed";
  static const String refunded = "refunded";
  static const String canceled = "canceled";
  static const String onHold = "onHold";
  static const String chargeback = "chargeback";
}

class PaymentMethod {
  static const String esewa = 'esewa';
  static const String bankaccount = 'bankaccount';
}

class DeliveryMethod {
  static const String doorDelivery = 'door-delivery';
  static const String pickUp = 'pick-up';
}
