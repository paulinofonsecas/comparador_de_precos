import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/repositories/avaliacao_repository.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/cubit/avaliacao_cubit.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/cubit/loja_details_cubit.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/cubit/loja_products_cubit.dart';
import 'package:comparador_de_precos/features/consumer/loja_details/widgets/loja_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LojaDetailsPage extends StatefulWidget {
  const LojaDetailsPage({required this.lojaId, super.key});

  final String lojaId;

  @override
  State<LojaDetailsPage> createState() => _LojaDetailsPageState();
}

class _LojaDetailsPageState extends State<LojaDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LojaDetailsCubit(
            getIt<LojaRepository>(),
          )..fetchLojaDetails(widget.lojaId),
        ),
        BlocProvider(
          create: (context) => AvaliacaoCubit(
            getIt<AvaliacaoRepository>(),
          )..fetchAvaliacoes(widget.lojaId),
        ),
        BlocProvider(
          create: (context) => LojaProductsCubit(
            productRepository: getIt<ProductCatalogRepository>(),
            lojaId: widget.lojaId,
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detalhes da Loja'),
            ),
            body: BlocBuilder<LojaDetailsCubit, LojaDetailsState>(
              builder: (context, state) {
                if (state is LojaDetailsLoading &&
                    state is! LojaDetailsSuccess) {
                  // Show loading only if no data yet
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LojaDetailsFailure) {
                  return Center(
                    child: Text('Erro: ${state.error}'),
                  );
                } else if (state is LojaDetailsSuccess) {
                  return LojaDetailsBody(loja: state.loja);
                }
                // Fallback or initial state - can use the initially passed widget.loja
                // This ensures that even before cubit loads, we show basic info.
                // Or, if fetchLojaDetails is called in create, LojaDetailsInitial might not be seen often.
                return const Center(
                  child: Text('Nenhuma loja encontrada'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
