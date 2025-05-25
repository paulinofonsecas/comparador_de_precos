import 'package:comparador_de_precos/features/consumer/inicio/inicio.dart';
import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/application/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/application/widgets/application_body.dart';

/// {@template application_page}
/// A description for ApplicationPage
/// {@endtemplate}
class ApplicationPage extends StatefulWidget {
  /// {@macro application_page}
  const ApplicationPage({super.key});

  /// The static route for ApplicationPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ApplicationPage());
  }

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  var _currentIndex = 0;

  final List<Widget> _pages = [
    InicioPage(),
    const Center(child: Text('Pesquisar')),
    const Center(child: Text('Favoritos')),
    const Center(child: Text('Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationBloc(),
      child: Scaffold(
        body: _pages[_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.qr_code_scanner,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
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
