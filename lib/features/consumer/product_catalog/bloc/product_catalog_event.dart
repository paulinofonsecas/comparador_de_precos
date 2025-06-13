import 'package:equatable/equatable.dart';

abstract class ProductCatalogEvent extends Equatable {
  const ProductCatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductCatalogEvent {
  const LoadProducts({this.refresh = false, this.categoryId = '0'});
  final bool refresh;
  final String? categoryId;

  @override
  List<Object?> get props => [categoryId, refresh];
}

class LoadMoreProducts extends ProductCatalogEvent {}

class FilterByCategory extends ProductCatalogEvent {

  const FilterByCategory(this.categoryId);
  final String? categoryId;

  @override
  List<Object?> get props => [categoryId];
}

class LoadCategories extends ProductCatalogEvent {}
