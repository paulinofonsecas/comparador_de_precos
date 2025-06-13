import 'package:comparador_de_precos/data/models/lista_compra.dart';
import 'package:comparador_de_precos/data/repositories/lista_compra_repository.dart';
import 'package:flutter/material.dart';

class ListaCompraForm extends StatefulWidget {
  const ListaCompraForm({
    required this.userId,
    required this.listaCompraRepository,
    this.listaCompra,
    super.key,
  });

  final String userId;
  final ListaCompra? listaCompra;
  final ListaCompraRepository listaCompraRepository;

  @override
  State<ListaCompraForm> createState() => _ListaCompraFormState();
}

class _ListaCompraFormState extends State<ListaCompraForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.listaCompra != null) {
      _nomeController.text = widget.listaCompra!.nome;
      if (widget.listaCompra!.descricao != null) {
        _descricaoController.text = widget.listaCompra!.descricao!;
      }
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvarLista() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      ListaCompra lista;

      if (widget.listaCompra == null) {
        // Criar nova lista
        lista = await widget.listaCompraRepository.criarListaCompra(
          nome: _nomeController.text.trim(),
          descricao: _descricaoController.text.trim().isNotEmpty
              ? _descricaoController.text.trim()
              : null,
        );
      } else {
        // Atualizar lista existente
        lista = widget.listaCompra!.copyWith(
          nome: _nomeController.text.trim(),
          descricao: _descricaoController.text.trim().isNotEmpty
              ? _descricaoController.text.trim()
              : null,
        );
        lista = await widget.listaCompraRepository.atualizarListaCompra(lista);
      }

      if (mounted) {
        Navigator.pop(context, lista);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.listaCompra == null
                  ? 'Erro ao criar lista de compras'
                  : 'Erro ao atualizar lista de compras',
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
            widget.listaCompra == null
                ? 'Nova Lista de Compras'
                : 'Editar Lista de Compras',
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
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome da Lista',
                    hintText: 'Ex: Compras do Mês',
                    prefixIcon: const Icon(Icons.shopping_cart),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, informe um nome para a lista';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição (opcional)',
                    hintText: 'Ex: Itens para o churrasco de domingo',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _salvarLista,
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
                        widget.listaCompra == null ? 'Criar Lista' : 'Salvar',
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
