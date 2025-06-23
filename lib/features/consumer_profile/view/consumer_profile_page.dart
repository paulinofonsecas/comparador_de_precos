import 'package:comparador_de_precos/features/consumer_profile/cubit/cubit.dart';
import 'package:comparador_de_precos/features/consumer_profile/widgets/consumer_profile_body.dart';
import 'package:flutter/material.dart';

/// {@template consumer_profile_page}
/// A description for ConsumerProfilePage
/// {@endtemplate}
class ConsumerProfilePage extends StatelessWidget {
  /// {@macro consumer_profile_page}
  const ConsumerProfilePage({super.key});

  /// The static route for ConsumerProfilePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const ConsumerProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConsumerProfileCubit(),
          
        ),
      ],
      child: const Scaffold(
        body: ConsumerProfileView(),
      ),
    );
  }
}

/// {@template consumer_profile_view}
/// 
/// {@endtemplate}
class ConsumerProfileView extends StatelessWidget {
  /// {@macro consumer_profile_view}
  const ConsumerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConsumerProfileBody();
  }
}
