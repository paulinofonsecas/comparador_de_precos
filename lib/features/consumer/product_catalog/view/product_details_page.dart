import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _repository = ProductCatalogRepository();
  bool _isLoading = true;
  Produto? _produto;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final produto = await _repository.getProdutoById(widget.productId);
      
      setState(() {
        _produto = produto;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_produto?.nome ?? 'Detalhes do Produto'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Erro ao carregar detalhes do produto',
              style: TextStyle(fontSize: 16, color: Colors.red[700]),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProductDetails,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_produto == null) {
      return const Center(
        child: Text(
          'Produto não encontrado',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Placeholder para a tela de detalhes do produto
    // Aqui seria implementada a comparação de preços entre lojas
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Esta é uma página de detalhes do produto onde será implementada a comparação de preços entre lojas.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              _produto!.nome,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_produto!.imagemUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _produto!.imagemUrl!,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: 200,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            if (_produto!.marca != null) ...[
              Text(
                'Marca: ${_produto!.marca}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
            ],
            if (_produto!.descricao != null) ...[
              Text(
                'Descrição: ${_produto!.descricao}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
            ],
            if (_produto!.categoria != null) ...[
              Text(
                'Categoria: ${_produto!.categoria!.nome}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
