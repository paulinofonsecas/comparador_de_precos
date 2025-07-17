import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/app/utils/number_format.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/widgets/custom_search_widget.dart';
import 'package:comparador_de_precos/features/consumer/application/bloc/application_bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/bloc/inicio_bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/widgets/market_scroll_list_item.dart';
import 'package:comparador_de_precos/features/consumer/inicio/widgets/market_scroll_vertical_list_item.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/view/lojas_proximas_page.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

/// {@template inicio_body}
/// Body of the InicioPage.
///
/// Add what it does
/// {@endtemplate}
class InicioBody extends StatelessWidget {
  /// {@macro inicio_body}
  const InicioBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the bloc is initialized and load lojas when the widget is built
    context.read<InicioBloc>().add(const LoadLojasParaVoceEvent());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _CustomSearchWidget(),
            const Gutter(),
            const ProdutosComMenoresPrecosSection(),
            const GutterLarge(),
            const AtualizacoesDePrecosMaisRecenteSection(),
            const GutterLarge(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Explorar',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_right),
                    iconAlignment: IconAlignment.end,
                    label:
                        const Text('Ver todas', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
            const Gutter(),
            BlocBuilder<InicioBloc, InicioState>(
              builder: (context, state) {
                if (state.status == InicioStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == InicioStatus.failure) {
                  return Center(
                    child: Text(state.errorMessage ?? 'Erro ao carregar lojas'),
                  );
                } else if (state.status == InicioStatus.success &&
                    state.lojasParaVoce.isNotEmpty) {
                  return Column(
                    spacing: 16,
                    children: state.lojasParaVoce
                        .map((loja) => MarketScrollVerticalListItem(loja: loja))
                        .toList(),
                  );
                } else {
                  return const Center(child: Text('Nenhuma loja encontrada'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSearchWidget extends StatelessWidget {
  const _CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          context
              .read<ApplicationBloc>()
              .add(const ChangePageApplicationEvent(1));
        },
        child: IgnorePointer(
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Pesquisar produto',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProdutosComMenoresPrecosSection extends StatefulWidget {
  const ProdutosComMenoresPrecosSection({
    super.key,
  });

  @override
  State<ProdutosComMenoresPrecosSection> createState() =>
      _ProdutosComMenoresPrecosSectionState();
}

class _ProdutosComMenoresPrecosSectionState
    extends State<ProdutosComMenoresPrecosSection> {
  late final ProductCatalogRepository _produtoRepository;
  List<Oferta> _precosBaixos = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _produtoRepository = getIt();
    _loadTopLojas();
  }

  Future<void> _loadTopLojas() async {
    try {
      final produtos = await _produtoRepository.getTop14Products();
      setState(() {
        _precosBaixos = produtos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar lojas: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Preços baixos',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const LojasProximasPage(),
                  ),
                );
              },
              icon: const Icon(Icons.chevron_right),
              iconAlignment: IconAlignment.end,
              label: const Text('Ver todas', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_error != null)
          const Center(child: Text("Ocorreu um erro. Tente novamente."))
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 4,
              children: _precosBaixos
                  .map(
                    (e) => ProductCard(
                      title: e.productName,
                      price: e.price,
                      imageUrl: e.productImage,
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String? trailing;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 215,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DefaultImageWidget(
                imageUrl: imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Título
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          // Preço + Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                numberFormat.format(price),
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class AtualizacoesDePrecosMaisRecenteSection extends StatefulWidget {
  const AtualizacoesDePrecosMaisRecenteSection({super.key});

  @override
  State<AtualizacoesDePrecosMaisRecenteSection> createState() =>
      _AtualizacoesDePrecosMaisRecenteSectionState();
}

class _AtualizacoesDePrecosMaisRecenteSectionState
    extends State<AtualizacoesDePrecosMaisRecenteSection> {
  late final ProductCatalogRepository _produtoRepository;
  List<Oferta> _precosRecentes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _produtoRepository = getIt();
    _loadPrecosRecentes();
  }

  Future<void> _loadPrecosRecentes() async {
    try {
      final lojas = await _produtoRepository.getRecentPriceUpdatedProducts();
      setState(() {
        _precosRecentes = lojas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar lojas próximas: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Atualizações de preços',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const LojasProximasPage(),
                  ),
                );
              },
              icon: const Icon(Icons.chevron_right),
              iconAlignment: IconAlignment.end,
              label: const Text('Ver todas', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_error != null)
          Center(child: Text(_error!))
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 4,
              children: _precosRecentes
                  .map(
                    (e) => ProductCard(
                      title: e.productName,
                      price: e.price,
                      imageUrl: e.productImage,
                      trailing: 'Há ${timeago.format(
                        e.lastPriceUpdate!,
                        locale: 'pt_BR_short',
                      )}',
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
