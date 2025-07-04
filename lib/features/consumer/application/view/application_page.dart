import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/auth/bloc/auth_bloc.dart';
import 'package:comparador_de_precos/features/auth/signin/cubit/login_cubit.dart';
import 'package:comparador_de_precos/features/auth/signin/view/signin_page.dart';
import 'package:comparador_de_precos/features/consumer/application/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/inicio.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/lista_compra_page.dart';
import 'package:comparador_de_precos/features/consumer/product_catalog/view/product_catalog_page.dart';
import 'package:comparador_de_precos/features/consumer/search/view/search_page.dart';
import 'package:comparador_de_precos/features/consumer_profile/consumer_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

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
  String _scanBarcode = 'Unknown';

  final List<Widget> _pages = [
    const InicioPage(),
    const SearchPage(),
    const ProductCatalogPage(),
    ListaCompraPage(
      userId: Supabase.instance.client.auth.currentUser!.id,
    ),
    const ConsumerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        if (state is SignOutSuccess) {
          Navigator.of(context).pushReplacement(
            SigninPage.route(),
          );
        }
      },
      child: BlocProvider(
        create: (context) => ApplicationBloc(),
        child: Scaffold(
          body: _pages[_currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              String barcodeScanRes;
              // Platform messages may fail, so we use a try/catch PlatformException.
              try {
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.QR);
                print(barcodeScanRes);
              } on PlatformException {
                barcodeScanRes = 'Failed to get platform version.';
              }

              // If the widget was removed from the tree while the asynchronous platform
              // message was in flight, we want to discard the reply rather than calling
              // setState to update our non-existent appearance.
              if (!mounted) return;

              setState(() {
                _scanBarcode = barcodeScanRes;
                log('Scanned barcode: $_scanBarcode');
              });
            },
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.qr_code_scanner,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
      ),
    );
  }
}
