part of 'get_item_lista_compra_cubit.dart';

sealed class GetItemListaCompraState extends Equatable {
  const GetItemListaCompraState();

  @override
  List<Object> get props => [];
}

final class GetItemListaCompraInitial extends GetItemListaCompraState {}

final class GetItemListaCompraLoading extends GetItemListaCompraState {}

final class GetItemListaCompraSuccess extends GetItemListaCompraState {
  const GetItemListaCompraSuccess({required this.itens});

  final List<ItemListaCompra> itens;

  @override
  List<Object> get props => [itens];
}

final class GetItemListaCompraError extends GetItemListaCompraState {
  const GetItemListaCompraError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
