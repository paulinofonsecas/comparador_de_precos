part of 'application_bloc.dart';

abstract class ApplicationEvent  extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_application_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomApplicationEvent extends ApplicationEvent {
  /// {@macro custom_application_event}
  const CustomApplicationEvent();
}
