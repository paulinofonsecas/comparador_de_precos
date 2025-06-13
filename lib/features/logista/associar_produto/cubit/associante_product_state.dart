part of 'associante_product_cubit.dart';

sealed class AssocianteProductState extends Equatable {
  const AssocianteProductState();

  @override
  List<Object> get props => [];
}

final class AssocianteProductInitial extends AssocianteProductState {}

final class AssocianteProductLoading extends AssocianteProductState {}

final class AssocianteProductSuccess extends AssocianteProductState {}

final class AssocianteProductFailure extends AssocianteProductState {

  const AssocianteProductFailure(this.message);
  final String message;
}
