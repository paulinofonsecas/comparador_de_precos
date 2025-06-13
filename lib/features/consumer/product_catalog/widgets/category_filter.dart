import 'package:comparador_de_precos/data/models/categoria.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    required this.categorias,
    required this.onCategorySelected,
    this.selectedCategoryId,
    super.key,
  });

  final List<Categoria> categorias;
  final String? selectedCategoryId;
  final void Function(String?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for the category section
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Text(
            'Categorias',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        // Category chips
        Container(
          height: 48,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categorias.length + 1, // +1 for 'All' option
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              // First item is 'All' categories
              if (index == 0) {
                final isSelected = selectedCategoryId == null;
                return _buildCategoryChip(
                  'Todos',
                  isSelected,
                  () => onCategorySelected(null),
                );
              }
              
              final categoria = categorias[index - 1];
              final isSelected = categoria.id == selectedCategoryId;
              return _buildCategoryChip(
                categoria.nome,
                isSelected,
                () => onCategorySelected(categoria.id),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
    return Builder(
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? theme.colorScheme.primary 
                        : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected 
                          ? theme.colorScheme.primary 
                          : theme.colorScheme.outline.withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: isSelected 
                        ? [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ] 
                        : null,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected 
                          ? theme.colorScheme.onPrimary 
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
