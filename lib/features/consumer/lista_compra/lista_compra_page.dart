import 'package:comparador_de_precos/app/utils/date_format.dart';
import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/repositories/lista_compra_repository.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/lista_compra_detalhes_page.dart';
import 'package:comparador_de_precos/features/consumer/lista_compra/widgets/lista_compra_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaCompraPage extends StatefulWidget {
  const ListaCompraPage({
    required this.userId,
    super.key,
  });

  final String userId;

  @override
  State<ListaCompraPage> createState() => _ListaCompraPageState();
}

class _ListaCompraPageState extends State<ListaCompraPage> {
  final _listaCompraRepository = ListaCompraRepository();
  List<ListaCompra> _listas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarListas();
  }

  Future<void> _carregarListas() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final listas =
          await _listaCompraRepository.getListasCompra(widget.userId);
      setState(() {
        _listas = listas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao carregar listas de compras'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _excluirLista(String listaId) async {
    try {
      final sucesso = await _listaCompraRepository.excluirListaCompra(listaId);
      if (sucesso && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lista excluída com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        _carregarListas();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao excluir lista'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao excluir lista'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _mostrarFormularioLista({ListaCompra? lista}) async {
    final result = await showModalBottomSheet<ListaCompra>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ListaCompraForm(
          userId: widget.userId,
          listaCompra: lista,
          listaCompraRepository: _listaCompraRepository,
        ),
      ),
    );

    if (result != null) {
      _carregarListas();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Listas de Compras'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _listas.isEmpty
              ? _buildEmptyState()
              : _buildListaComprasList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormularioLista,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma lista de compras encontrada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crie sua primeira lista de compras!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _mostrarFormularioLista,
            icon: const Icon(Icons.add),
            label: const Text('Nova Lista'),
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

  Widget _buildListaComprasList() {
    return RefreshIndicator(
      onRefresh: _carregarListas,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _listas.length,
        itemBuilder: (context, index) {
          final lista = _listas[index];
          final itemsComprados =
              lista.itens.where((item) => item.comprado).length;
          final totalItems = lista.itens.length;
          final progresso = totalItems > 0 ? itemsComprados / totalItems : 0.0;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCompraDetalhesPage(
                      listaId: lista.id,
                      userId: widget.userId,
                    ),
                  ),
                ).then((_) => _carregarListas());
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            lista.nome,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'editar') {
                              _mostrarFormularioLista(lista: lista);
                            } else if (value == 'excluir') {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Excluir Lista'),
                                  content: Text(
                                    'Tem certeza que deseja excluir a lista "${lista.nome}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _excluirLista(lista.id);
                                      },
                                      child: const Text('Excluir'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: 'editar',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Editar'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'excluir',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Excluir',
                                      style: TextStyle(color: Colors.red),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (lista.descricao != null &&
                        lista.descricao!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        lista.descricao!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Criada em ${dateFormat(lista.dataCriacao)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$totalItems itens ($itemsComprados comprados)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: progresso,
                      backgroundColor: Colors.grey[200],
                      color: progresso == 1.0 ? Colors.green : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListaCompraDetalhesPage(
                                  listaId: lista.id,
                                  userId: widget.userId,
                                ),
                              ),
                            ).then((_) => _carregarListas());
                          },
                          icon: const Icon(Icons.visibility, size: 16),
                          label: const Text('Ver Detalhes'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
