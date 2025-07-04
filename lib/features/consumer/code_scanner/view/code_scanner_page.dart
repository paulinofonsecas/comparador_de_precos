import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/cubit/cubit.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/widgets/code_scanner_body.dart';

/// {@template code_scanner_page}
/// A description for CodeScannerPage
/// {@endtemplate}
class CodeScannerPage extends StatelessWidget {
  /// {@macro code_scanner_page}
  const CodeScannerPage({super.key});

  /// The static route for CodeScannerPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const CodeScannerPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CodeScannerCubit(),
      child: const Scaffold(
        body: CodeScannerView(),
      ),
    );
  }    
}

/// {@template code_scanner_view}
/// Displays the Body of CodeScannerView
/// {@endtemplate}
class CodeScannerView extends StatelessWidget {
  /// {@macro code_scanner_view}
  const CodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CodeScannerBody();
  }
}
