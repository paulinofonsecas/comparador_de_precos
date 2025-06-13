import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/data/models/oferta_model.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/bloc/bloc.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/cubit/get_loja_cubit.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/cubit/get_more_products_of_market_cubit.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/cubit/get_product_cubit.dart';
import 'package:comparador_de_precos/features/consumer/oferta_details/widgets/oferta_details_body.dart';
import 'package:flutter/material.dart';

/// {@template oferta_details_bottom_sheet}
/// A bottom sheet that displays offer details
/// {@endtemplate}
class OfertaDetailsBottomSheet extends StatelessWidget {
  /// {@macro oferta_details_bottom_sheet}
  const OfertaDetailsBottomSheet({required this.oferta, super.key});

  final OfertaModel oferta;

  /// Shows the OfertaDetailsBottomSheet
  static Future<void> show(BuildContext context,
      {required OfertaModel oferta,}) {
    final size = MediaQuery.sizeOf(context);

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      constraints: BoxConstraints.expand(
        height: size.height * .95,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => OfertaDetailsBottomSheet(oferta: oferta),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OfertaDetailsBloc(oferta: oferta),
        ),
        BlocProvider(
          create: (context) => GetProductCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => GetLojaCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => GetMoreProductsOfMarketCubit(getIt()),
        ),
      ],
      child: const OfertaDetailsView(),
    );
  }
}

/// {@template oferta_details_view}
/// Displays the Body of OfertaDetailsView
/// {@endtemplate}
class OfertaDetailsView extends StatelessWidget {
  /// {@macro oferta_details_view}
  const OfertaDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfertaDetailsBody();
  }
}

// For backward compatibility, keeping the page class but making it use the bottom sheet
/// @deprecated Use OfertaDetailsBottomSheet instead
class OfertaDetailsPage extends StatelessWidget {
  /// @deprecated Use OfertaDetailsBottomSheet.show instead
  const OfertaDetailsPage({required this.oferta, super.key});

  final OfertaModel oferta;

  /// @deprecated Use OfertaDetailsBottomSheet.show instead
  static Route<dynamic> route({required OfertaModel oferta}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => OfertaDetailsPage(oferta: oferta),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show the bottom sheet and pop immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
      OfertaDetailsBottomSheet.show(context, oferta: oferta);
    });

    // Return an empty container as this will be popped immediately
    return Container();
  }
}
