import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/app/utils/number_format.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/cubit/get_produtos_associados_cubit.dart';
import 'package:flutter/material.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';

/// {@template logista_produtos_associados_body}
/// Body of the LogistaProdutosAssociadosPage.
///
/// Add what it does
/// {@endtemplate}
class LogistaProdutosAssociadosBody extends StatelessWidget {
  /// {@macro logista_produtos_associados_body}
  const LogistaProdutosAssociadosBody({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = getIt<UserProfile>();
    return BlocBuilder<GetProdutosAssociadosCubit, GetProdutosAssociadosState>(
      builder: (context, state) {
        if (state is GetProdutosAssociadosInitial) {
          context
              .read<GetProdutosAssociadosCubit>()
              .getProdutosAssociados(profile.id);
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetProdutosAssociadosLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetProdutosAssociadosFailure) {
          return Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Tentar novamente.'),
            ),
          );
        }

        if (state is GetProdutosAssociadosSuccess) {
          return _Body(
            state.produtos,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ignore: camel_case_types
class _Body extends StatelessWidget {
  const _Body(this.produtos);

  final List<ProdutoWithPrice> produtos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        final produto = produtos[index];
        return ListTile(
          title: Text(produto.produto.nome),
          subtitle: Text('Preço: ${numberFormat.format(produto.preco.preco)}'),
        );
      },
    );
  }
}
