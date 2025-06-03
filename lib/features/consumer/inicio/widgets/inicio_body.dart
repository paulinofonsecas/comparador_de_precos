import 'package:comparador_de_precos/data/models/loja.dart';
import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/features/consumer/inicio/bloc/inicio_bloc.dart';
import 'package:comparador_de_precos/features/consumer/inicio/widgets/market_scroll_list_item.dart';
import 'package:comparador_de_precos/features/consumer/inicio/widgets/market_scroll_vertical_list_item.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/view/lojas_proximas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
            const Top10MelhoreLojasWidget(),
            const GutterLarge(),
            const LojasProximasWidget(),
            const GutterLarge(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Para você',
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
            Gutter(),
            BlocBuilder<InicioBloc, InicioState>(
              builder: (context, state) {
                if (state.status == InicioStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == InicioStatus.failure) {
                  return Center(child: Text(state.errorMessage ?? 'Erro ao carregar lojas'));
                } else if (state.status == InicioStatus.success && state.lojasParaVoce.isNotEmpty) {
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

class Top10MelhoreLojasWidget extends StatefulWidget {
  const Top10MelhoreLojasWidget({
    super.key,
  });

  @override
  State<Top10MelhoreLojasWidget> createState() =>
      _Top10MelhoreLojasWidgetState();
}

class _Top10MelhoreLojasWidgetState extends State<Top10MelhoreLojasWidget> {
  late final LojaRepository _lojaRepository;
  List<Loja> _topLojas = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _lojaRepository = LojaRepository(supabaseClient: Supabase.instance.client);
    _loadTopLojas();
  }

  Future<void> _loadTopLojas() async {
    try {
      final lojas = await _lojaRepository.getTopRatedLojas(limit: 10);
      setState(() {
        _topLojas = lojas;
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
              'Top 10 melhores Lojas',
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
              children: _topLojas.isEmpty
                  ? const [Text('Nenhuma loja encontrada')]
                  : _topLojas
                      .map((loja) => MarketScrollListItem(
                            loja: loja,
                          ))
                      .toList(),
            ),
          ),
      ],
    );
  }
}

class LojasProximasWidget extends StatefulWidget {
  const LojasProximasWidget({super.key});

  @override
  State<LojasProximasWidget> createState() => _LojasProximasWidgetState();
}

class _LojasProximasWidgetState extends State<LojasProximasWidget> {
  late final LojaRepository _lojaRepository;
  List<Loja> _lojasProximas = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _lojaRepository = LojaRepository(supabaseClient: Supabase.instance.client);
    _loadLojasProximas();
  }

  Future<void> _loadLojasProximas() async {
    try {
      // Como não temos a localização do usuário aqui, vamos usar getAllLojas
      // Em uma implementação real, usaríamos getLojasProximas com a localização do usuário
      final lojas = await _lojaRepository.getAllLojas();
      setState(() {
        _lojasProximas = lojas;
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
              'Lojas Próximas',
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
              children: _lojasProximas.isEmpty
                  ? const [Text('Nenhuma loja encontrada')]
                  : _lojasProximas
                      .take(5)
                      .map((loja) => MarketScrollListItem(
                            loja: loja,
                          ))
                      .toList(),
            ),
          ),
      ],
    );
  }
}
