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
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          final isSelected = categoria.id == selectedCategoryId;
          return _buildCategoryChip(
            categoria.nome,
            isSelected,
            () => onCategorySelected(categoria.id),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.blue.withOpacity(0.2),
        checkmarkColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
