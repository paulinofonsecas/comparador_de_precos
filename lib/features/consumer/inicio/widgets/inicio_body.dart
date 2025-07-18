import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/app/utils/number_format.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/features/consumer/application/bloc/application_bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/widgets/market_scroll_vertical_list_item.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/view/lojas_proximas_page.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/view/oferta_details_page.dart';
import 'package:comparador_de_precos/features/consumer/product_details/view/product_details_page.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
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
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomSearchWidget(),
            Gutter(),
            ProdutosComMenoresPrecosSection(),
            GutterLarge(),
            AtualizacoesDePrecosMaisRecenteSection(),
            GutterLarge(),
            ExplorarSection(),
          ],
        ),
      ),
    );
  }
}

class ExplorarSection extends StatefulWidget {
  const ExplorarSection({super.key});

  @override
  State<ExplorarSection> createState() => _ExplorarSectionState();
}

class _ExplorarSectionState extends State<ExplorarSection> {
  late final ProductCatalogRepository _produtoRepository;
  List<Produto> _produtosDiversos = [];
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
      final produtos = await _produtoRepository.first20Products();
      setState(() {
        _produtosDiversos = produtos;
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
            ],
          ),
        ),
        const Gutter(),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_error != null)
          Center(child: Text(_error!))
        else if (_produtosDiversos.isEmpty)
          const Center(child: Text('Nenhum produto encontrado para explorar.'))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _produtosDiversos.length,
            itemBuilder: (context, index) {
              final produto = _produtosDiversos[index];

              return ProductCard(
                title: produto.nome,
                productID: produto.id,
                imageUrl: produto.imagemUrl ?? '',
              );
            },
          ),
      ],
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
            // TextButton.icon(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute<void>(
            //         builder: (context) => const LojasProximasPage(),
            //       ),
            //     );
            //   },
            //   icon: const Icon(Icons.chevron_right),
            //   iconAlignment: IconAlignment.end,
            //   label: const Text('Ver todas', style: TextStyle(fontSize: 13)),
            // ),
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
                      oferta: e,
                      storeName: e.storeName,
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
  final double? price;
  final String? storeName;
  final String? trailing;
  final Oferta? oferta;
  final String? productID;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.productID,
    this.oferta,
    this.storeName,
    this.price,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (oferta != null) {
          OfertaDetailsBottomSheet.show(
            context,
            oferta: oferta!,
          );
        }

        if (productID != null) {
          Navigator.of(context).push(
            ProductDetailsPage.route(productID!),
          );
        }
      },
      child: Container(
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            if (storeName != null)
              Text(
                storeName!,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (price != null)
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
          ],
        ),
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
            // TextButton.icon(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute<void>(
            //         builder: (context) => const LojasProximasPage(),
            //       ),
            //     );
            //   },
            //   icon: const Icon(Icons.chevron_right),
            //   iconAlignment: IconAlignment.end,
            //   label: const Text('Ver todas', style: TextStyle(fontSize: 13)),
            // ),
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
                      oferta: e,
                      imageUrl: e.productImage,
                      storeName: e.storeName,
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
