import 'package:camera_filter_carousel/widget/displaypicture_screen.dart';
import 'package:flutter/material.dart';
import 'filter_selector.dart';
import 'dart:io';

class PhotoFilterCarousel extends StatelessWidget {
  final String imagePath;

  const PhotoFilterCarousel({Key? key, required this.imagePath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Carousel')),
      body: Column(
        children: [
          Expanded(child: Image.file(File(imagePath), fit: BoxFit.cover)),
          FilterSelector(
            imagePath: imagePath,
            onFilterSelected: (filteredPath) {
              // Navigasi ke halaman untuk menampilkan gambar yang sudah difilter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          DisplayPictureScreen(imagePath: filteredPath),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
