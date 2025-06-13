import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/user_profile.dart';
import 'package:comparador_de_precos/data/repositories/produto_with_price.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/cubit/associante_product_cubit.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/cubit/get_all_products_cubit.dart';
import 'package:comparador_de_precos/features/logista/associar_produto/widgets/associar_produto_body.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/bloc/bloc.dart';
import 'package:comparador_de_precos/features/logista/logista_produtos_associados/cubit/get_produtos_associados_cubit.dart';
import 'package:flutter/material.dart';

/// {@template associar_produto_page}
/// A description for AssociarProdutoPage
/// {@endtemplate}
class AssociarProdutoPage extends StatelessWidget {
  /// {@macro associar_produto_page}
  const AssociarProdutoPage({this.produtoWithPrice, super.key});

  final ProductWithPrice? produtoWithPrice;

  /// The static route for AssociarProdutoPage
  static Route<dynamic> route({ProductWithPrice? produtoWithPrice}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => AssociarProdutoPage(
        produtoWithPrice: produtoWithPrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AssocianteProductCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => GetAllProductsCubit(getIt())..fetchAllProducts(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Associar Produto'),
        ),
        body: const AssociarProdutoView(),
      ),
    );
  }
}

/// {@template associar_produto_view}
/// Displays the Body of AssociarProdutoView
/// {@endtemplate}
class AssociarProdutoView extends StatelessWidget {
  const AssociarProdutoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profile = getIt<UserProfile>();

    return BlocListener<AssocianteProductCubit, AssocianteProductState>(
      listener: (context, state) {
        if (state is AssocianteProductSuccess) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produto associado com sucesso!'),
            ),
          );

          context
              .read<GetProdutosAssociadosCubit>()
              .getProdutosAssociados(profile.id);
        } else if (state is AssocianteProductFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao associar produto'),
            ),
          );
        }

        return;
      },
      child: const AssociarProdutoBody(),
    );
  }
}
