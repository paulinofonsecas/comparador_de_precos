import 'package:comparador_de_precos/data/models/solicitacao_loja.dart';
import 'package:comparador_de_precos/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';

class CustomSolicitacaoCard extends StatelessWidget {
  const CustomSolicitacaoCard({super.key, required this.solicitacao});

  final SolicitacaoLoja solicitacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Handle item tap, e.g., navigate to details screen
          print('Solicitação ${solicitacao.nome} clicada');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DefaultImageWidget(
                imageUrl:
                    'https://as1.ftcdn.net/v2/jpg/01/27/40/68/1000_F_127406856_K7ABxpHlydS6gFurI9kZsVaR3HsFp4yz.jpg',
                borderRadius: BorderRadius.circular(8),
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      solicitacao.nome as String,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('Localização: ${solicitacao.endereco}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                        'Data: ${solicitacao.createdAt.day}/${solicitacao.createdAt.month}/${solicitacao.createdAt.year}',
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: solicitacao.status == 'Pendente'
                            ? Colors.orange.withValues(alpha: .3)
                            : solicitacao.status == 'Aprovada'
                                ? Colors.green.withValues(alpha: .3)
                                : Colors.red.withValues(alpha: .3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Status: ${solicitacao.status}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
