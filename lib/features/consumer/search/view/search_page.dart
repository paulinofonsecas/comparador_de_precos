import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/search/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/search/widgets/search_body.dart';

/// {@template search_page}
/// A description for SearchPage
/// {@endtemplate}
class SearchPage extends StatelessWidget {
  /// {@macro search_page}
  const SearchPage({super.key});

  /// The static route for SearchPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: const Scaffold(
        body: SearchView(),
      ),
    );
  }    
}

/// {@template search_view}
/// Displays the Body of SearchView
/// {@endtemplate}
class SearchView extends StatelessWidget {
  /// {@macro search_view}
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SearchBody(),
    );
  }
}
