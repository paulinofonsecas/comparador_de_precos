import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/bloc/bloc.dart';

/// {@template oferta_details_body}
/// Body of the OfertaDetailsPage.
///
/// Add what it does
/// {@endtemplate}
class OfertaDetailsBody extends StatelessWidget {
  /// {@macro oferta_details_body}
  const OfertaDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfertaDetailsBloc, OfertaDetailsState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
