import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/aprovar_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/desaprovar_loja_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/cubit/get_lojistas_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_loja_details/widgets/admin_loja_details_body.dart';
import 'package:comparador_de_precos/features/logista/logista_dashboard/cubit/get_logista_profile_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminLojaDetailsBloc(getIt())
            ..add(LoadAdminLojaDetailsEvent(lojaId: lojaId)),
        ),
        BlocProvider(
          create: (context) => AprovarLojaCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => DesaprovarLojaCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => GetLojistasCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => GetLogistaProfileCubit(getIt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Loja'),
          centerTitle: true,
        ),
        body: AdminLojaDetailsView(
          key: Key('admin_loja_details_view_//'),
          lojaId: lojaId,
        ),
      ),
    );
  }
}

/// {@template admin_loja_details_view}
/// Displays the Body of AdminLojaDetailsView
/// {@endtemplate}
class AdminLojaDetailsView extends StatelessWidget {
  /// {@macro admin_loja_details_view}
  const AdminLojaDetailsView({
    super.key,
    required this.lojaId,
  });

  final String lojaId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdminLojaDetailsBloc, AdminLojaDetailsState>(
          listener: (context, state) {
            if (state is AdminLojaDetailsLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carregando detalhes da loja...')),
              );
            } else if (state is AdminLojaDetailsLoaded) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            } else if (state is AdminLojaDetailsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<AprovarLojaCubit, AprovarLojaState>(
          listener: (context, state) {
            if (state is AprovarLojaSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Loja aprovada com sucesso!')),
              );

              context.read<AdminLojaDetailsBloc>().add(
                    LoadAdminLojaDetailsEvent(
                      lojaId: lojaId,
                    ),
                  );
            } else if (state is AprovarLojaFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: const Text('Erro ao aprovar loja')),
              );
            }
          },
        ),
        BlocListener<DesaprovarLojaCubit, DesaprovarLojaState>(
          listener: (context, state) {
            if (state is DesaprovarLojaSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Loja desaprovada com sucesso!')),
              );

              context.read<AdminLojaDetailsBloc>().add(
                    LoadAdminLojaDetailsEvent(
                      lojaId: lojaId,
                    ),
                  );
            } else if (state is DesaprovarLojaFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Erro ao desaprovar loja')),
              );
            }
          },
        ),
      ],
      child: const AdminLojaDetailsBody(),
    );
  }
}
