part of 'get_lojas_info_cubit.dart';

sealed class GetLojasInfoState extends Equatable {
  const GetLojasInfoState();

  @override
  List<Object> get props => [];
}

final class GetLojasInfoInitial extends GetLojasInfoState {}

final class GetLojasInfoLoading extends GetLojasInfoState {}

final class GetLojasInfoSuccess extends GetLojasInfoState {
  const GetLojasInfoSuccess(this.lojasInfo);
  final Map<String, dynamic> lojasInfo;

  @override
  List<Object> get props => [lojasInfo];
}

final class GetLojasInfoFailure extends GetLojasInfoState {
  const GetLojasInfoFailure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
