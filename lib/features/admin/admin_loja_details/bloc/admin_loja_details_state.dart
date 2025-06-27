part of 'admin_loja_details_bloc.dart';

/// {@template admin_loja_details_state}
/// AdminLojaDetailsState description
/// {@endtemplate}
class AdminLojaDetailsState extends Equatable {
  /// {@macro admin_loja_details_state}
  const AdminLojaDetailsState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current AdminLojaDetailsState with property changes
  AdminLojaDetailsState copyWith({
    String? customProperty,
  }) {
    return AdminLojaDetailsState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template admin_loja_details_initial}
/// The initial state of AdminLojaDetailsState
/// {@endtemplate}
class AdminLojaDetailsInitial extends AdminLojaDetailsState {
  /// {@macro admin_loja_details_initial}
  const AdminLojaDetailsInitial() : super();
}

class AdminLojaDetailsLoading extends AdminLojaDetailsState {}

class AdminLojaDetailsLoaded extends AdminLojaDetailsState {
  /// {@macro admin_loja_details_loaded}
  const AdminLojaDetailsLoaded({required this.loja});

  /// The loaded loja details
  final Loja loja;

  @override
  List<Object> get props => [loja];
}

class AdminLojaDetailsError extends AdminLojaDetailsState {
  /// {@macro admin_loja_details_error}
  const AdminLojaDetailsError({required this.message});

  /// The error message
  final String message;

  @override
  List<Object> get props => [message];
}
