import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/features/consumer/inicio/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/widgets/inicio_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template inicio_page}
/// A description for InicioPage
/// {@endtemplate}
class InicioPage extends StatelessWidget {
  /// {@macro inicio_page}
  const InicioPage({super.key});

  /// The static route for InicioPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const InicioPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InicioBloc(
        lojaRepository: LojaRepository(
          supabaseClient: Supabase.instance.client,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comparador de Preços'),
          centerTitle: true,
        ),
        body: const InicioView(),
      ),
    );
  }    
}

/// {@template inicio_view}
/// Displays the Body of InicioView
/// {@endtemplate}
class InicioView extends StatelessWidget {
  /// {@macro inicio_view}
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return const InicioBody();
  }
}
