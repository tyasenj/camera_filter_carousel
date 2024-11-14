import 'package:camera_filter_carousel/widget/filter_carousel.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dapatkan daftar kamera yang tersedia di perangkat.
  final cameras = await availableCameras();

  // Ambil kamera pertama dari daftar kamera yang tersedia.
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:
          firstCamera != null
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
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Screen')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika kamera sudah siap, tampilkan preview kamera
            return CameraPreview(_controller);
          } else {
            // Tampilkan indikator loading jika kamera belum siap
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Tunggu hingga kamera siap
            await _initializeControllerFuture;

            // Ambil gambar
            final image = await _controller.takePicture();

            // Setelah gambar diambil, pindah ke halaman filter carousel
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => PhotoFilterCarousel(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
