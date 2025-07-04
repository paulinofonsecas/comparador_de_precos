import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/consumer/code_scanner/cubit/cubit.dart';

/// {@template code_scanner_body}
/// Body of the CodeScannerPage.
///
/// Add what it does
/// {@endtemplate}
class CodeScannerBody extends StatelessWidget {
  /// {@macro code_scanner_body}
  const CodeScannerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeScannerCubit, CodeScannerState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
