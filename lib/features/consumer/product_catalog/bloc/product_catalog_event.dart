import 'package:equatable/equatable.dart';

abstract class ProductCatalogEvent extends Equatable {
  const ProductCatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductCatalogEvent {
  final bool refresh;
  
  const LoadProducts({this.refresh = false});
  
  @override
  List<Object?> get props => [refresh];
}

class LoadMoreProducts extends ProductCatalogEvent {}

class FilterByCategory extends ProductCatalogEvent {
  final String? categoryId;
  
  const FilterByCategory(this.categoryId);
  
  @override
  List<Object?> get props => [categoryId];
}

class LoadCategories extends ProductCatalogEvent {}
