import 'package:comparador_de_precos/features/consumer/loja_details/view/loja_details_page.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/cubit/lojas_proximas_cubit.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/cubit/lojas_proximas_state.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/widgets/loja_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LojasProximasBody extends StatelessWidget {
  const LojasProximasBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LojasProximasCubit, LojasProximasState>(
      builder: (context, state) {
        if (state is LojasProximasLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LojasProximasFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<LojasProximasCubit>().carregarLojasProximas();
                  },
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        if (state is LojasProximasSuccess) {
          if (state.lojas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.store_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    state.temLocalizacao && state.raioMaxKm != null
                        ? 'Nenhuma loja encontrada em um raio de ${state.raioMaxKm!.toStringAsFixed(1)} km'
                        : 'Nenhuma loja encontrada',
                    textAlign: TextAlign.center,
                  ),
                  if (state.temLocalizacao && state.raioMaxKm != null) ...[  
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<LojasProximasCubit>()
                            .atualizarRaioMaximo(null);
                      },
                      child: const Text('Mostrar todas as lojas'),
                    ),
                  ],
                ],
              ),
            );
          }

          return Column(
            children: [
              // Filtro de raio
              if (state.temLocalizacao)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildRaioFilter(context, state),
                ),
              // Mensagem de localização
              if (!state.temLocalizacao)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildLocationMessage(context),
                ),
              // Lista de lojas
              Expanded(
                child: ListView.builder(
                  itemCount: state.lojas.length,
                  itemBuilder: (context, index) {
                    final loja = state.lojas[index];
                    return LojaItem(
                      loja: loja,
                      mostrarDistancia: state.temLocalizacao,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => LojaDetailsPage(lojaId: loja.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }

        // Estado inicial
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildRaioFilter(BuildContext context, LojasProximasSuccess state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.filter_alt),
                const SizedBox(width: 8),
                Text(
                  'Filtrar por distância',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<double?>(
                    decoration: const InputDecoration(
                      labelText: 'Raio máximo',
                      border: OutlineInputBorder(),
                    ),
                    value: state.raioMaxKm,
                    items: const [
                      DropdownMenuItem<double?>(
                        child: Text('Todas as lojas'),
                      ),
                      DropdownMenuItem<double?>(
                        value: 1,
                        child: Text('1 km'),
                      ),
                      DropdownMenuItem<double?>(
                        value: 2,
                        child: Text('2 km'),
                      ),
                      DropdownMenuItem<double?>(
                        value: 5,
                        child: Text('5 km'),
                      ),
                      DropdownMenuItem<double?>(
                        value: 10,
                        child: Text('10 km'),
                      ),
                      DropdownMenuItem<double?>(
                        value: 20,
                        child: Text('20 km'),
                      ),
                      DropdownMenuItem<double?>(
                        value: 50,
                        child: Text('50 km'),
                      ),
                    ],
                    onChanged: (value) {
                      context
                          .read<LojasProximasCubit>()
                          .atualizarRaioMaximo(value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationMessage(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_off, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Localização não disponível',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Ative a localização para ver as lojas mais próximas de você.',
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .read<LojasProximasCubit>()
                    .solicitarPermissaoERecarregar();
              },
              icon: const Icon(Icons.location_on),
              label: const Text('Ativar localização'),
            ),
          ],
        ),
      ),
    );
  }
}
