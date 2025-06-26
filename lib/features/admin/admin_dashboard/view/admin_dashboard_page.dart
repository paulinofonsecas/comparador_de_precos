import 'package:comparador_de_precos/data/models/my_user.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/bloc/bloc.dart';
import 'package:comparador_de_precos/features/admin/admin_dashboard/widgets/admin_dashboard_body.dart';
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
    return BlocProvider(
      create: (context) => AdminDashboardBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
        ),
        body: const AdminDashboardView(),
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
    return const AdminDashboardBody();
  }
}
