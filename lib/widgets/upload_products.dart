// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:comparador_de_precos/app/constants.dart';
import 'package:comparador_de_precos/experiement_upload/product_socia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateScrappedProducts extends StatefulWidget {
  const UpdateScrappedProducts({super.key});

  @override
  State<UpdateScrappedProducts> createState() => _UpdateScrappedProductsState();
}

class _UpdateScrappedProductsState extends State<UpdateScrappedProducts> {
  List<SociaProduct> subList = <SociaProduct>[];
  double percentage = 0;
  String produtoEmCurso = '';
  String categoriaAtual = 'alimentares';

  Future<String> addImageToProduct(
    String productId,
    Uint8List imageBytes,
  ) async {
    try {
      const bucketName = 'products';
      final imagePath = 'images/produto_$productId.jpg';

      await Supabase.instance.client.storage
          .from(bucketName)
          .remove([imagePath]);

      final result =
          await Supabase.instance.client.storage.from(bucketName).uploadBinary(
                imagePath,
                imageBytes,
                retryAttempts: 2,
                fileOptions: const FileOptions(
                  upsert: true,
                ),
              );

      final finalUrl = kStorageBaseUrl + result;

      if (productId.isNotEmpty) {
        await Supabase.instance.client.from('produtos').update({
          'imagem_url': finalUrl,
        }).eq('id', productId);
      }

      return finalUrl;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> downloadImage(String productId, String url) async {
    try {
      // Baixar a imagem
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // pegar o id do produto
        return await addImageToProduct(
          productId,
          response.bodyBytes,
        );
      } else {
        print('Falha ao se conectar à URL: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Erro ao baixar a imagem, $e');
      return '';
    }
  }

  Future<void> uploadProducts(
    String assetFile,
    String categoriaId,
  ) async {
    setState(() {
      percentage = 0;
    });

    final alimentaresRaw =
        await rootBundle.loadString('assets/data/$assetFile.json');

    final readedProducts = (json.decode(alimentaresRaw) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(SociaProduct.fromMap)
        .toList();

    subList = readedProducts.sublist(10);
    for (final product in subList) {
      setState(() {
        produtoEmCurso = product.produto;
      });

      final id = await Supabase.instance.client
          .from('produtos')
          .insert({
            'nome': product.produto,
            'descricao': product.descricao,
            'categoria_id': categoriaId,
          })
          .select('id')
          .single();

      final productId = id['id'] as String;

      if (product.foto != null) {
        await downloadImage(
          productId,
          product.foto!,
        );
      }

      setState(() {
        percentage = readedProducts.indexOf(product) / subList.length;
      });

      // imprime a persentagem de progresso
      if (kDebugMode) {
        print(
          'Progresso: '
          '${(readedProducts.indexOf(product) / subList.length) * 100} ',
        );
      }
    }
    setState(() {
      percentage = 0;
      produtoEmCurso = '';
    });
    print('Upload concluído');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Produtos'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gutter(),
              LinearProgressIndicator(
                value: percentage,
              ),
              const GutterLarge(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Produto: $produtoEmCurso'),
                  const GutterSmall(),
                  Text(
                    'Progresso: ${(percentage * 100).toStringAsFixed(2)}%',
                  ),
                  const GutterSmall(),
                  Text('Categoria: $categoriaAtual'),
                ],
              ),
              const GutterLarge(),
              if (percentage == 0)
                Align(
                  child: ElevatedButton(
                    onPressed: () {
                      uploadProducts(
                        'alimentares',
                        '081c1efc-193c-45e0-9957-f824e554d38b',
                      );
                    },
                    child: const Text('Upload'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
