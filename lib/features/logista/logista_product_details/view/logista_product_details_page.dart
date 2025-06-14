import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/cubit/cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/cubit/product_avaliable_cubit.dart';
import 'package:comparador_de_precos/features/logista/logista_product_details/widgets/logista_product_details_body.dart';
import 'package:flutter/material.dart';

/// {@template logista_product_details_page}
/// A description for LogistaProductDetailsPage
/// {@endtemplate}
class LogistaProductDetailsPage extends StatelessWidget {
  /// {@macro logista_product_details_page}
  const LogistaProductDetailsPage({
    required this.produtoId,
    required this.logistaId,
    super.key,
  });

  final String produtoId;
  final String logistaId;

  /// The static route for LogistaProductDetailsPage
  static Route<dynamic> route(String produtoId, String logistaId) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => LogistaProductDetailsPage(
        produtoId: produtoId,
        logistaId: logistaId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogistaProductDetailsCubit(
            produtoId: produtoId,
            logistaId: logistaId,
            logistaRepository: getIt(),
          )..getProdutoDetails(produtoId),
        ),
        BlocProvider(
          create: (context) => ProductAvaliableCubit(getIt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        body: LogistaProductDetailsView(
          produtoId: produtoId,
        ),
      ),
    );
  }
}

/// {@template logista_product_details_view}
/// Displays the Body of LogistaProductDetailsView
/// {@endtemplate}
class LogistaProductDetailsView extends StatelessWidget {
  /// {@macro logista_product_details_view}
  const LogistaProductDetailsView({required this.produtoId, super.key});

  final String produtoId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductAvaliableCubit, ProductAvaliableState>(
      listener: (context, state) {
        if (state is ProductAvaliableSuccess) {
          context
              .read<LogistaProductDetailsCubit>()
              .getProdutoDetails(produtoId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.visibility
                    ? 'Produto tornado disponível'
                    : 'Produto tornado indisponível',
              ),
            ),
          );
        }

        if (state is ProductAvaliableFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Falha ao alterar a disponibilidade',
              ),
            ),
          );
        }
      },
      child: const LogistaProductDetailsBody(),
    );
  }
}
