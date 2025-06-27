import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/widgets/admin_loja_details_body.dart';
import 'package:flutter/material.dart';

/// {@template admin_loja_details_page}
/// A description for AdminLojaDetailsPage
/// {@endtemplate}
class AdminLojaDetailsPage extends StatelessWidget {
  /// {@macro admin_loja_details_page}
  const AdminLojaDetailsPage({
    required this.lojaId,
    super.key,
  });

  final String lojaId;

  /// The static route for AdminLojaDetailsPage
  static Route<dynamic> route({required String lojaId}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => AdminLojaDetailsPage(lojaId: lojaId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLojaDetailsBloc(getIt())
        ..add(LoadAdminLojaDetailsEvent(lojaId: lojaId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Loja'),
          centerTitle: true,
        ),
        body: const AdminLojaDetailsView(),
      ),
    );
  }
}

/// {@template admin_loja_details_view}
/// Displays the Body of AdminLojaDetailsView
/// {@endtemplate}
class AdminLojaDetailsView extends StatelessWidget {
  /// {@macro admin_loja_details_view}
  const AdminLojaDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminLojaDetailsBody();
  }
}
