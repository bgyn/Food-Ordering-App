import 'package:uuid/uuid.dart';

class Product {
  final String pid;
  final String image;
  final String name;
  final int price;
  final String description;
  final DateTime createdAt;
  Product({
    String? pid,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
  }) : pid = pid ?? const Uuid().v4();

  Product copyWith({
    String? pid,
    String? image,
    String? name,
    int? price,
    String? description,
    DateTime? createdAt,
  }) {
    return Product(
      pid: pid ?? this.pid,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'createdAt': createdAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      pid: map['pid'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      description: map['description'] ?? '',
      createdAt: map['createdAt'].toDate()  ,
    );
  }

  @override
  String toString() {
    return 'ProductModel(pid: $pid, image: $image, name: $name, price: $price, description : $description)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.pid == pid &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return pid.hashCode ^
        image.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        createdAt.hashCode;
  }
}