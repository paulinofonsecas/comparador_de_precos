import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/models/produto.dart';
import 'package:comparador_de_precos/data/repositories/lista_compra_repository.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/data/repositories/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemListaCompraForm extends StatefulWidget {
  const ItemListaCompraForm({
    required this.listaId,
    required this.listaCompraRepository,
    required this.productRepository,
    this.item,
    this.produtoPreSelecionado,
    super.key,
  });

  final String listaId;
  final ItemListaCompra? item;
  final Produto? produtoPreSelecionado;
  final ListaCompraRepository listaCompraRepository;
  final ProductCatalogRepository productRepository;

  @override
  State<ItemListaCompraForm> createState() => _ItemListaCompraFormState();
}

class _ItemListaCompraFormState extends State<ItemListaCompraForm> {
  final _formKey = GlobalKey<FormState>();
  final _quantidadeController = TextEditingController();
  final _observacaoController = TextEditingController();
  final _produtoSearchController = TextEditingController();
  
  bool _isLoading = false;
  bool _isSearching = false;
  List<Produto> _produtosEncontrados = [];
  Produto? _produtoSelecionado;

  @override
  void initState() {
    super.initState();
    
    if (widget.item != null) {
      _produtoSelecionado = widget.item!.produto;
      _quantidadeController.text = widget.item!.quantidade.toString();
      if (widget.item!.observacao != null) {
        _observacaoController.text = widget.item!.observacao!;
      }
      if (_produtoSelecionado != null) {
        _produtoSearchController.text = _produtoSelecionado!.nome;
      }
    } else if (widget.produtoPreSelecionado != null) {
      _produtoSelecionado = widget.produtoPreSelecionado;
      _produtoSearchController.text = _produtoSelecionado!.nome;
      _quantidadeController.text = '1';
    }
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _observacaoController.dispose();
    _produtoSearchController.dispose();
    super.dispose();
  }

  Future<void> _buscarProdutos(String query) async {
    if (query.isEmpty) {
      setState(() {
        _produtosEncontrados = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final produtos = await getIt<SearchProductRepository>().searchProducts(query);
      setState(() {
        _produtosEncontrados = produtos;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _produtosEncontrados = [];
        _isSearching = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao buscar produtos'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _selecionarProduto(Produto produto) {
    setState(() {
      _produtoSelecionado = produto;
      _produtoSearchController.text = produto.nome;
      _produtosEncontrados = [];
    });
  }

  Future<void> _salvarItem() async {
    if (!_formKey.currentState!.validate()) return;
    if (_produtoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um produto'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final quantidade = int.parse(_quantidadeController.text.trim());
      final observacao = _observacaoController.text.trim().isNotEmpty
          ? _observacaoController.text.trim()
          : null;

      if (widget.item == null) {
        // Adicionar novo item
        await widget.listaCompraRepository.adicionarItemListaCompra(
          listaId: widget.listaId,
          produtoId: _produtoSelecionado!.id,
          quantidade: quantidade,
          observacao: observacao,
          produto: _produtoSelecionado,
        );
      } else {
        // Atualizar item existente
        final itemAtualizado = widget.item!.copyWith(
          quantidade: quantidade,
          observacao: observacao,
          produto: _produtoSelecionado,
        );
        
        await widget.listaCompraRepository.atualizarItemListaCompra(
          listaId: widget.listaId,
          item: itemAtualizado,
        );
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.item == null
                  ? 'Erro ao adicionar item'
                  : 'Erro ao atualizar item',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.item == null
                ? 'Adicionar Item à Lista'
                : 'Editar Item da Lista',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Campo de busca de produtos
                TextFormField(
                  controller: _produtoSearchController,
                  decoration: InputDecoration(
                    labelText: 'Produto',
                    hintText: 'Buscar produto...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _produtoSearchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _produtoSearchController.clear();
                              setState(() {
                                _produtosEncontrados = [];
                                _produtoSelecionado = null;
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    if (_produtoSelecionado != null &&
                        value != _produtoSelecionado!.nome) {
                      setState(() {
                        _produtoSelecionado = null;
                      });
                    }
                    _buscarProdutos(value);
                  },
                  validator: (value) {
                    if (_produtoSelecionado == null) {
                      return 'Selecione um produto válido';
                    }
                    return null;
                  },
                ),
                
                // Lista de resultados da busca
                if (_isSearching)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_produtosEncontrados.isNotEmpty)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _produtosEncontrados.length,
                      itemBuilder: (context, index) {
                        final produto = _produtosEncontrados[index];
                        return ListTile(
                          title: Text(produto.nome),
                          subtitle: produto.marca != null
                              ? Text(produto.marca!)
                              : null,
                          onTap: () => _selecionarProduto(produto),
                        );
                      },
                    ),
                  ),
                
                const SizedBox(height: 16),
                
                // Campo de quantidade
                TextFormField(
                  controller: _quantidadeController,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    prefixIcon: const Icon(Icons.format_list_numbered),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a quantidade';
                    }
                    final quantidade = int.tryParse(value);
                    if (quantidade == null || quantidade <= 0) {
                      return 'Quantidade deve ser maior que zero';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Campo de observação
                TextFormField(
                  controller: _observacaoController,
                  decoration: InputDecoration(
                    labelText: 'Observação (opcional)',
                    hintText: 'Ex: Marca preferida, tamanho, etc.',
                    prefixIcon: const Icon(Icons.note),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _salvarItem,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        widget.item == null ? 'Adicionar' : 'Salvar',
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
