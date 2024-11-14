import 'package:flutter/material.dart';

class FilterSelector extends StatelessWidget {
  final String imagePath;
  final Function(String) onFilterSelected;

  const FilterSelector({
    Key? key,
    required this.imagePath,
    required this.onFilterSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Contoh Filter: ini dapat diubah sesuai kebutuhan Anda
          IconButton(
            icon: const Icon(Icons.filter_1),
            onPressed: () {
              // Misalnya: Ganti dengan jalur gambar yang difilter
              onFilterSelected(imagePath);
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_2),
            onPressed: () {
              // Misalnya: Ganti dengan jalur gambar yang difilter
              onFilterSelected(imagePath);
            },
          ),
          // Tambahkan lebih banyak filter di sini
        ],
      ),
    );
  }
}
