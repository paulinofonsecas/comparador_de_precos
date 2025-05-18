import 'package:comparador_de_precos/features/client/product_catalog/view/product_catalog_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Para fins de demonstração, você pode alternar entre SigninPage e ProductCatalogPage
      // home: const SigninPage(),
      home: const ProductCatalogPage(),
    );
  }
}
