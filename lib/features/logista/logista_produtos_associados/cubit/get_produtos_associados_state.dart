part of 'get_produtos_associados_cubit.dart';

sealed class GetProdutosAssociadosState extends Equatable {
  const GetProdutosAssociadosState();

  @override
  List<Object> get props => [];
}

final class GetProdutosAssociadosInitial extends GetProdutosAssociadosState {}

final class GetProdutosAssociadosLoading extends GetProdutosAssociadosState {}

final class GetProdutosAssociadosSuccess extends GetProdutosAssociadosState {
  const GetProdutosAssociadosSuccess(this.produtos);

  final List<ProdutoWithPrice> produtos;

  @override
  List<Object> get props => [produtos];
}

final class GetProdutosAssociadosFailure extends GetProdutosAssociadosState {
  const GetProdutosAssociadosFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
