import 'dart:developer';

import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/cubit/admin_get_lojas_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/cubit/search_lojas_cubit.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/widgets/custom_search_widget.dart';
import 'package:comparador_de_precos/features/admin/admin_gestao_lojas/widgets/loja_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template admin_gestao_lojas_body}
/// Body of the AdminGestaoLojasPage.
///
/// Add what it does
/// {@endtemplate}
class AdminGestaoLojasBody extends StatefulWidget {
  const AdminGestaoLojasBody({super.key});

  @override
  State<AdminGestaoLojasBody> createState() => _AdminGestaoLojasBodyState();
}

class _AdminGestaoLojasBodyState extends State<AdminGestaoLojasBody> {
  late final TextEditingController textController;
  late final ScrollController scrollController;

  var page = 1;
  List<Loja> lojasFiltradas = [];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    scrollController = ScrollController();

    textController.addListener(() async {
      final query = textController.text.toLowerCase();

      await Future.delayed(const Duration(milliseconds: 500), () {
        // ignore: use_build_context_synchronously
        context.read<SearchLojasCubit>().search(query);
      });
    });

    // Listen to scroll events to load more lojas when reaching the bottom
    scrollController.addListener(() {
      // if search is active, do not paginate
      if (textController.text.isNotEmpty) return;

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<AdminGetLojasCubit>().paginateLojas(page);
      }
    });

    // Fetch initial list of stores
    context.read<AdminGetLojasCubit>().paginateLojas(page);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AdminGetLojasCubit>().state;

    return MultiBlocListener(
      listeners: [
        BlocListener<SearchLojasCubit, SearchLojasState>(
          listener: (context, state) {
            if (state is SearchLojasSuccess) {
              setState(() {
                lojasFiltradas = state.lojas;
              });
            }

            if (state is SearchLojasFailure) {
              // Handle failure state if needed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao buscar lojas: //${state.message}'),
                ),
              );
            }
          },
        ),
        BlocListener<AdminGetLojasCubit, AdminGetLojasState>(
          listener: (context, state) {
            if (state is AdminGetLojasPaginatedSuccess) {
              log('Lojas paginadas: ${state.lojas.length}');

              // Append new lojas to the filtered list
              setState(() {
                lojasFiltradas.addAll(state.lojas);
                page++;
              });
            }

            if (state is AdminGetLojasFailure) {
              log('Erro ao obter loja: ${state.message}');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Erro ao obter loja')),
              );
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            CustomSearchWidget(textController: textController),
            const GutterTiny(),
            if (state is AdminGetLojasLoading) ...[
              const GutterTiny(),
              const Center(
                child: LinearProgressIndicator(),
              ),
            ],
            if (lojasFiltradas.isEmpty && state is! AdminGetLojasLoading) ...[
              const GutterTiny(),
              Expanded(
                child: Center(
                  child: Text(
                    'Nenhuma loja encontrada',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
            const GutterTiny(),
            if (lojasFiltradas.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: lojasFiltradas.length,
                  itemBuilder: (context, index) {
                    return LojaListTileWidget(
                      loja: lojasFiltradas[index],
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
