import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class UProduct {
  // Adicione outros campos conforme necessário

  UProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.price,
    required this.featuredImage,
    // Adicione outros parâmetros
  });

  factory UProduct.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  final String id;
  final String title;
  final String description;
  final String url;
  @JsonKey(name: 'price')
  final Price price;
  @JsonKey(name: 'featured_image')
  final Image featuredImage;

  void get imageUrl {}

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Price {
  Price({
    required this.value,
    required this.valueOriginal,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  final String value;
  final String valueOriginal;
  final Currency currency;
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Currency {
  // Adicione outros campos conforme necessário

  Currency({
    required this.description,
    required this.code,
    // Adicione outros parâmetros
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  final String description;
  final String code;
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class Image {
  // Adicione outros campos conforme necessário

  Image({
    required this.alt,
    required this.source,
    // Adicione outros parâmetros
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  final String alt;
  final String source;
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class ApiResponse {
  ApiResponse({
    required this.status,
    required this.count,
    required this.products,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  final String status;
  final String count;
  final List<UProduct> products;

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
