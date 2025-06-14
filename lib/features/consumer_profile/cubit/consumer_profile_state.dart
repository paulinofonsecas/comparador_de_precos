part of 'consumer_profile_cubit.dart';

/// {@template consumer_profile}
/// ConsumerProfileState description
/// {@endtemplate}
class ConsumerProfileState extends Equatable {
  /// {@macro consumer_profile}
  const ConsumerProfileState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ConsumerProfileState with property changes
  ConsumerProfileState copyWith({
    String? customProperty,
  }) {
    return ConsumerProfileState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}
/// {@template consumer_profile_initial}
/// The initial state of ConsumerProfileState
/// {@endtemplate}
class ConsumerProfileInitial extends ConsumerProfileState {
  /// {@macro consumer_profile_initial}
  const ConsumerProfileInitial() : super();
}
