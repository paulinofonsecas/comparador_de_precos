part of 'get_logista_profile_cubit.dart';

sealed class GetLogistaProfileState extends Equatable {
  const GetLogistaProfileState();

  @override
  List<Object> get props => [];
}

final class GetLogistaProfileInitial extends GetLogistaProfileState {}

final class GetLogistaProfileLoading extends GetLogistaProfileState {}

class GetLogistaProfileSuccess extends GetLogistaProfileState {
  const GetLogistaProfileSuccess(this.profile);

  final UserProfile profile;

  @override
  List<Object> get props => [profile];
}

class GetLogistaProfileFailure extends GetLogistaProfileState {
  const GetLogistaProfileFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];

}
