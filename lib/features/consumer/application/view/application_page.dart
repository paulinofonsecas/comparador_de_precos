import 'package:comparador_de_precos/features/consumer/application/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/inicio.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/lista_compra_page.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/view/product_catalog_page.dart';
import 'package:comparador_de_precos/features/consumer/search/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    const InicioPage(),
    const SearchPage(),
    const ProductCatalogPage(),
    ListaCompraPage(
      userId: Supabase.instance.client.auth.currentUser!.id,
    ),
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
              icon: Icon(Icons.store),
              label: 'Catálogo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Listas',
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
