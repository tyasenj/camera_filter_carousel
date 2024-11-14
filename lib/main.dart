import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:camera_filter_carousel/widget/takepicture_screen.dart';
import 'package:camera_filter_carousel/widget/filter_carousel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mendapatkan daftar kamera yang tersedia di perangkat.
  final cameras = await availableCameras();

  // Mengambil kamera pertama dari daftar kamera yang tersedia.
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: firstCamera != null
          ? TakePictureAndFilterScreen(camera: firstCamera)
          : const Center(child: Text("No camera available")),
    ),
  );
}

class TakePictureAndFilterScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureAndFilterScreen({Key? key, required this.camera})
      : super(key: key);

  @override
  _TakePictureAndFilterScreenState createState() =>
      _TakePictureAndFilterScreenState();
}

class _TakePictureAndFilterScreenState
    extends State<TakePictureAndFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Filter Carousel'),
      ),
      body: TakePictureScreen(
        camera: widget.camera,
        onPictureTaken: (String imagePath) {
          // Setelah gambar diambil, navigasi ke halaman filter carousel.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoFilterCarousel(imagePath: imagePath),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Memastikan kontrol kamera telah diinisialisasi.
          final controller = CameraController(
            widget.camera,
            ResolutionPreset.high,
          );
          await controller.initialize();

          // Mengambil gambar saat tombol kamera ditekan.
          final image = await controller.takePicture();

          // Navigasi ke halaman filter carousel.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoFilterCarousel(imagePath: image.path),
            ),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
