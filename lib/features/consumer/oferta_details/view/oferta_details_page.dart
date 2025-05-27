import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/widgets/oferta_details_body.dart';

/// {@template oferta_details_page}
/// A description for OfertaDetailsPage
/// {@endtemplate}
class OfertaDetailsPage extends StatelessWidget {
  /// {@macro oferta_details_page}
  const OfertaDetailsPage({super.key});

  /// The static route for OfertaDetailsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const OfertaDetailsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfertaDetailsBloc(),
      child: const Scaffold(
        body: OfertaDetailsView(),
      ),
    );
  }    
}

/// {@template oferta_details_view}
/// Displays the Body of OfertaDetailsView
/// {@endtemplate}
class OfertaDetailsView extends StatelessWidget {
  /// {@macro oferta_details_view}
  const OfertaDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfertaDetailsBody();
  }
}
