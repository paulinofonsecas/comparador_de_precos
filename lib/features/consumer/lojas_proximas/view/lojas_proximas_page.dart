import 'package:comparador_de_precos/data/repositories/loja_repository.dart';
import 'package:comparador_de_precos/data/services/location_service.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/cubit/lojas_proximas_cubit.dart';
import 'package:comparador_de_precos/features/consumer/lojas_proximas/widgets/lojas_proximas_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LojasProximasPage extends StatelessWidget {
  const LojasProximasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LojasProximasCubit(
        lojaRepository: GetIt.I<LojaRepository>(),
        locationService: GetIt.I<LocationService>(),
      )..carregarLojasProximas(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lojas Próximas'),
              actions: [
                BlocBuilder(
                  bloc: BlocProvider.of<LojasProximasCubit>(context),
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        context.read<LojasProximasCubit>().carregarLojasProximas();
                      },
                    );
                  },
                ),
              ],
            ),
            body: const LojasProximasBody(),
          );
        },
      ),
    );
  }
}
