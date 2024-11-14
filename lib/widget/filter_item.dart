import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final int filterIndex;
  final String imagePath;

  const FilterItem({
    Key? key,
    required this.filterIndex,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tambahkan aksi penerapan filter di sini
        print('Filter $filterIndex applied!');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Filter $filterIndex',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
