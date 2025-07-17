// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class Oferta {
  Oferta({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productId,
    required this.storeId,
    required this.storeName,
    required this.storeLocation,
    required this.price,
    required this.lastPriceUpdate,
    required this.promotionPrice,
  });

  final String id;
  final String productName;
  final String productImage;
  final String productId;
  final String storeId;
  final String storeName;
  final String storeLocation;
  final double price;
  final DateTime? lastPriceUpdate;
  final double? promotionPrice;

  Oferta copyWith({
    String? id,
    String? productName,
    String? productImage,
    String? productId,
    String? storeId,
    String? storeName,
    String? storeLocation,
    double? price,
    DateTime? lastPriceUpdate,
    double? promotionPrice,
  }) {
    return Oferta(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productId: productId ?? this.productId,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeLocation: storeLocation ?? this.storeLocation,
      price: price ?? this.price,
      lastPriceUpdate: lastPriceUpdate ?? this.lastPriceUpdate,
      promotionPrice: promotionPrice ?? this.promotionPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_name': productName,
      'product_image': productImage,
      'product_id': productId,
      'store_id': storeId,
      'store_name': storeName,
      'store_location': storeLocation,
      'price': price,
      'last_price_update': lastPriceUpdate?.millisecondsSinceEpoch,
      'promotion_price': promotionPrice,
    };
  }

  factory Oferta.fromMap(Map<String, dynamic> map) {
    log(map.toString());

    return Oferta(
      id: map['id'] as String,
      productName: map['product_title'] as String,
      productImage: map['product_image'] as String? ?? '',
      productId: map['returned_product_id'] as String,
      storeId: map['store_id'] as String,
      storeName: map['store_name'] as String,
      storeLocation: map['store_location'] as String,
      price: map['price'] as double,
      lastPriceUpdate: map['last_price_update'] != null
          ? DateTime.parse(map['last_price_update'] as String)
          : null,
      promotionPrice: map['promotional_price'] as double?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Oferta.fromJson(String source) =>
      Oferta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OfertaModel(id: $id, productName: $productName, productImage: $productImage, productId: $productId, storeId: $storeId, storeName: $storeName, storeLocation: $storeLocation, price: $price, lastPriceUpdate: $lastPriceUpdate)';
  }

  @override
  bool operator ==(covariant Oferta other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productName == productName &&
        other.productImage == productImage &&
        other.productId == productId &&
        other.storeId == storeId &&
        other.storeName == storeName &&
        other.storeLocation == storeLocation &&
        other.price == price &&
        other.lastPriceUpdate == lastPriceUpdate &&
        other.promotionPrice == promotionPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        productImage.hashCode ^
        productId.hashCode ^
        storeId.hashCode ^
        storeName.hashCode ^
        storeLocation.hashCode ^
        price.hashCode ^
        lastPriceUpdate.hashCode ^
        promotionPrice.hashCode;
  }
}
