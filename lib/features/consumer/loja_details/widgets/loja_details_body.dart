import 'package:comparador_de_precos/data/models/categoria.dart';
import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../cubit/avaliacao_cubit.dart';
import '../cubit/loja_products_cubit.dart';
import '../cubit/loja_products_state.dart';

class LojaDetailsBody extends StatefulWidget {
  const LojaDetailsBody({super.key, required this.loja});

  final Loja loja;

  @override
  State<LojaDetailsBody> createState() => _LojaDetailsBodyState();
}

class _LojaDetailsBodyState extends State<LojaDetailsBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _priceFilters = ['Todos', 'Menor preço', 'Maior preço'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Load products when the widget is initialized
    context.read<LojaProductsCubit>().loadProducts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: _buildStoreHeader(),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Tab(text: 'Produtos'),
                    Tab(text: 'Informações'),
                    Tab(text: 'Avaliações'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildProductsTab(),
            _buildInfoTab(),
            _buildReviewsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store image and basic info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store logo/image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.loja.logoUrl != null
                    ? Image.network(
                        widget.loja.logoUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.store, size: 50),
                          );
                        },
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.store, size: 50),
                      ),
              ),
              const Gutter(),
              // Store info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.loja.nome,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 4),
                    if (widget.loja.endereco != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.loja.endereco!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(width: 4),
                    if (widget.loja.telefoneContato != null)
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            widget.loja.telefoneContato!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    const SizedBox(width: 4),
                    // Rating
                    BlocBuilder<AvaliacaoCubit, AvaliacaoState>(
                      builder: (context, state) {
                        double rating = 0.0;
                        int numAvaliacoes = 0;
                        if (state is AvaliacaoSuccess) {
                          rating = state.mediaClassificacao;
                          numAvaliacoes = state.numeroAvaliacoes;
                        } else {
                          // Usar valores do modelo Loja se disponíveis
                          final classificacaoMedia =
                              widget.loja.classificacaoMedia;
                          if (classificacaoMedia != null) {
                            rating = classificacaoMedia;
                            numAvaliacoes = widget.loja.numeroAvaliacoes ?? 0;
                          }
                        }

                        return Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rating > 0 ? rating.toStringAsFixed(1) : 'N/A',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(' (${numAvaliacoes} avaliações)'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Store description
          if (widget.loja.descricao != null) ...[
            Text(
              widget.loja.descricao!,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.call, 'Ligar'),
              _buildActionButton(Icons.share, 'Compartilhar'),
              _buildActionButton(Icons.directions, 'Direções'),
              _buildActionButton(Icons.bookmark_border, 'Salvar'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: Theme.of(context).primaryColor,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildProductsTab() {
    return BlocBuilder<LojaProductsCubit, LojaProductsState>(
      builder: (context, state) {
        return Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  context.read<LojaProductsCubit>().updateSearchQuery(value);
                },
                decoration: InputDecoration(
                  hintText: 'Buscar produtos...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Category filter
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: DropdownButton<String>(
                      hint: const Text('Categoria'),
                      value: state.selectedCategoryId,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        context
                            .read<LojaProductsCubit>()
                            .updateCategoryFilter(newValue);
                      },
                      items: context
                          .read<LojaProductsCubit>()
                          .categorias
                          .map<DropdownMenuItem<String>>((Categoria category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.nome),
                        );
                      }).toList(),
                    ),
                  ),
                  // Price filter
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: DropdownButton<String>(
                      hint: const Text('Preço'),
                      value: state.priceFilter,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context
                              .read<LojaProductsCubit>()
                              .updatePriceFilter(newValue);
                        }
                      },
                      items: _priceFilters
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Product list
            Expanded(
              child: _buildProductList(state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductList(LojaProductsState state) {
    switch (state.status) {
      case LojaProductsStatus.initial:
      case LojaProductsStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case LojaProductsStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Erro ao carregar produtos: ${state.errorMessage}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<LojaProductsCubit>().loadProducts();
                },
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        );
      case LojaProductsStatus.success:
        final filteredProducts = state.filteredProducts;
        return filteredProducts.isEmpty
            ? const Center(child: Text('Nenhum produto encontrado'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return _buildProductCard(product);
                },
              );
    }
  }

  Widget _buildProductCard(Produto product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigator.push(
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.imagemUrl != null
                    ? Image.network(
                        product.imagemUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 40),
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 40),
                      ),
              ),
              const Gutter(),
              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    if (product.categoria != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.categoria!.nome,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    const SizedBox(width: 4),
                    // Product name
                    Text(
                      product.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // Brand
                    if (product.marca != null)
                      Text(
                        product.marca!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    const SizedBox(width: 4),
                    // Price
                    if (product.precoMinimo != null)
                      Text(
                        'R\$ ${product.precoMinimo!.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
              // Add to cart button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_shopping_cart),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoSection(
          'Horário de Funcionamento',
          [
            _buildInfoRow('Segunda a Sexta', '08:00 - 20:00'),
            _buildInfoRow('Sábado', '08:00 - 18:00'),
            _buildInfoRow('Domingo', '09:00 - 14:00'),
          ],
        ),
        const Divider(),
        _buildInfoSection(
          'Formas de Pagamento',
          [
            _buildInfoRow(Icons.credit_card, 'Cartão de Crédito'),
            _buildInfoRow(Icons.money, 'Dinheiro'),
            _buildInfoRow(Icons.qr_code, 'PIX'),
          ],
        ),
        const Divider(),
        _buildInfoSection(
          'Serviços',
          [
            _buildInfoRow(Icons.delivery_dining, 'Entrega a domicílio'),
            _buildInfoRow(Icons.shopping_bag_outlined, 'Retirada na loja'),
            _buildInfoRow(Icons.local_parking, 'Estacionamento'),
          ],
        ),
        const Divider(),
        _buildInfoSection(
          'Localização',
          [
            Stack(
              alignment: Alignment.topRight,
              fit: StackFit.passthrough,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: MapControllerWidget(
                    localizacao: LatLng(
                      widget.loja.latitude!,
                      widget.loja.longitude!,
                    ),
                    width: double.infinity,
                    height: 250,
                    initialZoom: 17,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                    icon: const Icon(
                      Icons.fullscreen,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const GutterTiny(),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(dynamic icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon is IconData)
            Icon(icon, size: 20, color: Colors.grey[600])
          else if (icon is String)
            Text(
              icon,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return BlocBuilder<AvaliacaoCubit, AvaliacaoState>(
      builder: (context, state) {
        if (state is AvaliacaoLoading && state is! AvaliacaoSuccess) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AvaliacaoFailure) {
          return Center(child: Text('Erro: ${state.error}'));
        } else if (state is AvaliacaoSuccess) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Rating summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      state.mediaClassificacao.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildStarRating(state.mediaClassificacao),
                    ),
                    Text('Baseado em ${state.numeroAvaliacoes} avaliações',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Review list
              if (state.avaliacoes.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Nenhuma avaliação ainda. Seja o primeiro a avaliar!',
                      style: TextStyle(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ...state.avaliacoes.map((avaliacao) => _buildReviewCard(
                      name: avaliacao.usuarioNome ?? 'Anônimo',
                      date: _formatDate(avaliacao.createdAt),
                      rating: avaliacao.classificacao.toInt(),
                      comment: avaliacao.comentario ?? '',
                    )),
              // Add review button
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _showAddReviewDialog(context),
                icon: const Icon(Icons.rate_review),
                label: const Text('Adicionar Avaliação'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('Nenhuma avaliação disponível'));
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  List<Widget> _buildStarRating(double rating) {
    final List<Widget> stars = [];
    final int fullStars = rating.floor();
    final bool hasHalfStar = rating - fullStars >= 0.5;

    // Adicionar estrelas cheias
    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber));
    }

    // Adicionar meia estrela se necessário
    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber));
    }

    // Adicionar estrelas vazias
    final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    for (int i = 0; i < emptyStars; i++) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber));
    }

    return stars;
  }

  void _showAddReviewDialog(BuildContext context) {
    double classificacao = 5.0;
    final comentarioController = TextEditingController();
    final avaliacaoCubit = context.read<AvaliacaoCubit>();

    showDialog<void>(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: avaliacaoCubit,
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Adicionar Avaliação'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Classificação'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: Icon(
                          index < classificacao
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            classificacao = index + 1.0;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: comentarioController,
                    decoration: const InputDecoration(
                      labelText: 'Comentário (opcional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final myUser = Supabase.instance.client.auth.currentUser;
                    if (myUser == null) {
                      Navigator.pop(ctx);
                      return;
                    }
                    // Aqui você deve implementar a lógica para obter o ID do usuário logado
                    // Por enquanto, usaremos valores de exemplo
                    avaliacaoCubit.adicionarAvaliacao(
                      lojaId: widget.loja.id,
                      usuarioId: myUser.id,
                      usuarioNome: 'Usuario',
                      classificacao: classificacao,
                      comentario: comentarioController.text.isNotEmpty
                          ? comentarioController.text
                          : null,
                    );
                    Navigator.pop(ctx);
                  },
                  child: const Text('Enviar'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String date,
    required int rating,
    required String comment,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Text(name[0]),
                ),
                const GutterSmall(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
