import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/cubit/get_lojas_info_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/admin_dashboard_body.dart';
import 'package:comparador_de_precos/features/auth/signin/cubit/login_cubit.dart';
import 'package:comparador_de_precos/features/auth/signin/view/signin_page.dart';
import 'package:flutter/material.dart';

/// {@template admin_dashboard_page}
/// A description for AdminDashboardPage
/// {@endtemplate}
class AdminDashboardPage extends StatelessWidget {
  /// {@macro admin_dashboard_page}
  const AdminDashboardPage({
    required this.user,
    super.key,
  });

  final MyUser user;

  /// The static route for AdminDashboardPage
  static Route<dynamic> route({required MyUser user}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => AdminDashboardPage(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminDashboardBloc(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => GetLojasInfoCubit(getIt()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Painel Administrativo'),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    context.read<LoginCubit>().signOut();
                  },
                ),
              ],
            ),
            body: const AdminDashboardView(),
          );
        },
      ),
    );
  }
}

/// {@template admin_dashboard_view}
/// Displays the Body of AdminDashboardView
/// {@endtemplate}
class AdminDashboardView extends StatelessWidget {
  /// {@macro admin_dashboard_view}
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushReplacement(
            SigninPage.route(),
          );
        }
      },
      child: const AdminDashboardBody(),
    );
  }
}
