// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UProduct _$ProductFromJson(Map<String, dynamic> json) => UProduct(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      featuredImage:
          Image.fromJson(json['featured_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(UProduct instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'price': instance.price,
      'featured_image': instance.featuredImage,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      value: json['value'] as String,
      valueOriginal: json['valueOriginal'] as String,
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'value': instance.value,
      'valueOriginal': instance.valueOriginal,
      'currency': instance.currency,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      description: json['description'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'description': instance.description,
      'code': instance.code,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      alt: json['alt'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'alt': instance.alt,
      'source': instance.source,
    };

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      status: json['status'] as String,
      count: json['count'] as String,
      products: (json['response']['products'] as List<dynamic>)
          .map((e) => UProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'count': instance.count,
      'products': instance.products,
    };
