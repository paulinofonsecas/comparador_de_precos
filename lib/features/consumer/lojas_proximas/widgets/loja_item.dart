import 'package:comparador_de_precos/data/models/loja_com_distancia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class LojaItem extends StatelessWidget {
  const LojaItem({
    super.key,
    required this.loja,
    required this.onTap,
    required this.mostrarDistancia,
  });

  final LojaComDistancia loja;
  final VoidCallback onTap;
  final bool mostrarDistancia;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo da loja
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: loja.logoUrl != null
                    ? Image.network(
                        loja.logoUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
              Gutter(),
              // Informações da loja
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loja.nome,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (loja.endereco != null) ...[  
                      const GutterTiny(),
                      Text(
                        loja.endereco!,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (mostrarDistancia) ...[  
                      const GutterTiny(),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            _formatarDistancia(loja.distanciaKm),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ],
                    if (loja.telefoneContato != null) ...[  
                      const GutterTiny(),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            loja.telefoneContato!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey.shade300,
      child: const Icon(Icons.store, size: 40, color: Colors.grey),
    );
  }

  String _formatarDistancia(double distanciaKm) {
    if (distanciaKm < 1) {
      // Converter para metros se for menos de 1 km
      final metros = (distanciaKm * 1000).round();
      return '$metros m';
    } else if (distanciaKm < 10) {
      // Mostrar uma casa decimal se for menos de 10 km
      return '${distanciaKm.toStringAsFixed(1)} km';
    } else {
      // Arredondar para inteiro se for 10 km ou mais
      return '${distanciaKm.round()} km';
    }
  }
}
