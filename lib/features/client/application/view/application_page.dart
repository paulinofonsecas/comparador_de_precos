import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/client/application/bloc/bloc.dart';
import 'package:comparador_de_precos/features/client/application/widgets/application_body.dart';

/// {@template application_page}
/// A description for ApplicationPage
/// {@endtemplate}
class ApplicationPage extends StatelessWidget {
  /// {@macro application_page}
  const ApplicationPage({super.key});

  /// The static route for ApplicationPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ApplicationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationBloc(),
      child: Scaffold(
        body: ApplicationView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle floating action button press
          },
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.qr_code_scanner,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Pesquisar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
          onTap: (index) {
            // Handle bottom navigation tap
          },
        ),
      ),
    );
  }
}

/// {@template application_view}
/// Displays the Body of ApplicationView
/// {@endtemplate}
class ApplicationView extends StatelessWidget {
  /// {@macro application_view}
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ApplicationBody();
  }
}
