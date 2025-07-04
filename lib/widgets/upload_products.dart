// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:comparador_de_precos/app/constants.dart';
import 'package:comparador_de_precos/experiement_upload/product_socia.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
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
  String categoriaAtual = 'bebidas';

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
                    onPressed: () async {
                      await createRandomProductsPrices();
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

Future<void> createRandomProductsPrices() async {
  dev.log('Criando precos aleatorios para produtos');
  final random = Random();
  final products = await Supabase.instance.client.from('produtos').select('id');
  final lojas = [
    '1d6fd860-3bff-4d72-848d-9a37d88c7d62',
    '04f239ea-7b1e-4019-9d29-fbb266035e5a',
    '0e8f07dc-b4b5-458c-afaa-ea7d14c2efb4',
    'f7ddcd12-bf5e-405b-a3b2-a945a589567d',
    'b76b8158-18e5-481d-9371-54689e9bb44a',
    'f844924f-9352-4b8f-814d-73c61c7d283e',
    'f92f2ad4-234f-49b2-b3d9-27f465282a66',
    '139ea004-6bcc-4c8c-9cac-69f5fec33f76',
    '66be33d2-21ab-4652-81cd-d2334ec050ab',
    'b007742a-b68b-4f1a-a8bf-3d22a756ad6d',
    'd4ca2e5a-52f4-4082-b915-5565879e82e9',
    '2a7ad3b4-706d-4067-a408-2f268691b8fd',
    'ee47f7bb-d831-42a0-8a30-752efb1f1fa0',
    '9eef999f-d795-44a4-8b98-591927ae7edd',
    '2a30aa9f-b6a7-4658-95f8-e6f394db2551',
    '56dac548-bc45-4679-b3a6-76e01c7f4e20',
    '9b69121c-95fc-458d-8778-4cf515df9265',
    'f5a3130c-5d30-4b90-84d8-79e290b174b0',
    '886145d9-fa05-42cd-ba2f-841d87277469',
    '2349e85c-f8d3-4f1b-aa71-0842ecc885f1',
    '44aa31bc-40c2-42b4-90b5-76b6bf3b2629',
    '0e52228e-8d53-466d-92a7-94f4068324be',
    '93f81889-1edd-4a7a-bc12-bf2ad916f80b',
    'f05e42a1-a93c-4b6b-a40b-21c6ceb3d3fc',
    'd01d55f0-7b47-4322-8484-51fc3982e873',
    'bd3c0e86-62da-43db-a8ae-5da15aa96bd2',
    '45eae276-3779-42c4-b241-24b59691a696',
    '7691a4f7-889e-4d3b-ac39-d6b80797dff2',
    '5c5f6379-c221-4ec5-b8e1-0bc2f36a0608',
    '0e9fd818-c7d5-4e34-8ae4-d93105c31926',
    '82758bdc-e2cd-4915-a746-7291e212a740',
    'f8325de5-3df4-4d0b-aec3-400df8d9faf8',
    '4b2543c2-b71c-4ac9-9e52-8d130fe35d61',
    'e2897345-5738-443d-b688-02908d65fd20',
    '0a8cccf1-d860-4e26-9d05-1f060315e725',
    '356fd9f9-85da-4f27-9e4f-950cf3176a41',
    '853b2f1f-5e1d-4025-b45c-c83067df7de0',
    '8444c8ba-3c3a-4bfb-ab04-ac7f541fe939',
    '9463b14b-bae8-4ddf-a83a-e99e295c37a7',
    '9f8f7365-12a4-4d2e-893a-fe2f750bffa5',
    '7533e14d-4fdf-4d4f-b2c9-04ea6dd75ac3',
    '4f58e36f-d797-4c94-83ab-40ae9bedc135',
    'e3c81b83-de33-4be5-adcc-ba040d56f6d3',
    'fc7dd51f-2a06-4763-92a6-1853840b57c1',
    'd92fef16-f262-4731-965f-e1a69feeb3b5',
    'cada3ba4-8d42-49ca-9b18-ce1bb8b9101d',
    '05093657-667e-479d-8e76-57a03da2666c',
    'f2c36eca-edb1-4576-8238-15c1c9272405',
    '6faade7e-9d5f-4b29-9072-769e1daff522',
    '02d62f94-ee7d-463c-9158-51b956c83165',
    '8d0da35b-fc95-4449-adc2-56fb29c13813',
    '4440d9e3-36d4-4f7e-8e27-e7f7ed99bc6b',
  ];

  if (products.isEmpty) {
    dev.log('Nenhum produto encontrado');
    return;
  }

  for (final product in products.sublist(4)) {
    final productId = product['id'] as String;

    for (final loja in lojas.sublist(0, random.nextInt(5) + 3)) {
      final preco = random.nextInt(5000) + 1;
      await Supabase.instance.client.from('precos').insert({
        'produto_id': productId,
        'loja_id': loja,
        'preco': preco.toStringAsFixed(2),
        'data_atualizacao': DateTime.now().toIso8601String(),
      });
    }
  }

  dev.log('Precos aleatorios criados com sucesso');
}
