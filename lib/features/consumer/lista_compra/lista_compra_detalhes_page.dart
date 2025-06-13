import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/repositories/lista_compra_repository.dart';
import 'package:comparador_de_precos/data/repositories/product_catalog_repository.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/widgets/item_lista_compra_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaCompraDetalhesPage extends StatefulWidget {
  const ListaCompraDetalhesPage({
    required this.listaId,
    required this.userId,
    super.key,
  });

  final String listaId;
  final String userId;

  @override
  State<ListaCompraDetalhesPage> createState() =>
      _ListaCompraDetalhesPageState();
}

class _ListaCompraDetalhesPageState extends State<ListaCompraDetalhesPage> {
  final _listaCompraRepository = ListaCompraRepository();
  final _productRepository = ProductCatalogRepository();

  ListaCompra? _lista;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  Future<void> _carregarLista() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final lista = await _listaCompraRepository.getListaCompra(widget.listaId);
      setState(() {
        _lista = lista;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao carregar detalhes da lista'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _marcarItemComoComprado(String itemId, bool comprado) async {
    try {
      await _listaCompraRepository.marcarItemComoComprado(
        listaId: widget.listaId,
        itemId: itemId,
        comprado: comprado,
      );
      _carregarLista();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao atualizar item'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _removerItem(String itemId) async {
    try {
      await _listaCompraRepository.removerItemListaCompra(
        listaId: widget.listaId,
        itemId: itemId,
      );
      _carregarLista();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item removido com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao remover item'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _mostrarFormularioItem({ItemListaCompra? item}) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ItemListaCompraForm(
          listaId: widget.listaId,
          item: item,
          listaCompraRepository: _listaCompraRepository,
          productRepository: _productRepository,
        ),
      ),
    );

    if (result ?? false == true) {
      await _carregarLista();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_lista?.nome ?? 'Detalhes da Lista'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _carregarLista,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lista == null
              ? _buildErroState()
              : _buildListaDetalhes(),
      floatingActionButton: _lista != null
          ? FloatingActionButton(
              onPressed: _mostrarFormularioItem,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildErroState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'Lista não encontrada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }

  Widget _buildListaDetalhes() {
    final itemsComprados = _lista!.itens.where((item) => item.comprado).length;
    final totalItems = _lista!.itens.length;
    final progresso = totalItems > 0 ? itemsComprados / totalItems : 0.0;

    return Column(
      children: [
        _buildCabecalhoLista(progresso, itemsComprados, totalItems),
        Expanded(
          child:
              _lista!.itens.isEmpty ? _buildEmptyState() : _buildListaItens(),
        ),
      ],
    );
  }

  Widget _buildCabecalhoLista(
      double progresso, int itemsComprados, int totalItems,) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_lista!.descricao != null && _lista!.descricao!.isNotEmpty) ...[
            Text(
              _lista!.descricao!,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                'Criada em ${DateFormat('dd/MM/yyyy').format(_lista!.dataCriacao)}',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progresso: ${(progresso * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progresso,
                      backgroundColor: Colors.grey[200],
                      color: progresso == 1.0 ? Colors.green : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    '$itemsComprados/$totalItems',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'comprados',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum item na lista',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione produtos à sua lista de compras',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _mostrarFormularioItem,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Item'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListaItens() {
    // Ordenar itens: não comprados primeiro, depois comprados
    final itensOrdenados = [..._lista!.itens];
    itensOrdenados.sort((a, b) {
      if (a.comprado == b.comprado) {
        return 0;
      }
      return a.comprado ? 1 : -1;
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itensOrdenados.length,
      itemBuilder: (context, index) {
        final item = itensOrdenados[index];

        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Remover Item'),
                    content: const Text(
                      'Tem certeza que deseja remover este item da lista?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Remover'),
                      ),
                    ],
                  ),
                ) ??
                false;
          },
          onDismissed: (direction) {
            _removerItem(item.id);
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Checkbox(
                value: item.comprado,
                onChanged: (value) {
                  if (value != null) {
                    _marcarItemComoComprado(item.id, value);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: Text(
                item.produto?.nome ?? 'Produto não encontrado',
                style: TextStyle(
                  decoration: item.comprado
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: item.comprado ? Colors.grey : null,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Quantidade: ${item.quantidade}'),
                  if (item.observacao != null &&
                      item.observacao!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Obs: ${item.observacao}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () => _mostrarFormularioItem(item: item),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Remover Item'),
                          content: const Text(
                            'Tem certeza que deseja remover este item da lista?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _removerItem(item.id);
                              },
                              child: const Text('Remover'),
                            ),
                          ],
                        ),
                      );
                    },
                    tooltip: 'Remover',
                  ),
                ],
              ),
              isThreeLine:
                  item.observacao != null && item.observacao!.isNotEmpty,
            ),
          ),
        );
      },
    );
  }
}
