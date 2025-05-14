import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/client/application/bloc/bloc.dart';

/// {@template application_body}
/// Body of the ApplicationPage.
///
/// Add what it does
/// {@endtemplate}
class ApplicationBody extends StatelessWidget {
  /// {@macro application_body}
  const ApplicationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
