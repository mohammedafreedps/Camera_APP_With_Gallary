import 'package:flutter/material.dart';
import 'package:camapp/gallary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future CaptureAndSaveImage() async {
    final picked = ImagePicker();
    final XFile? image = await picked.pickImage(source: ImageSource.camera);

    if (image != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDirectory = Directory('${appDir.path}/images');

      if (!imagesDirectory.existsSync()) {
        imagesDirectory.createSync(recursive: true);
      }

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '${appDir.path}/images/ImgeFrom_$timestamp.jpg';

      await File(image.path).copy(filePath);

      print("Image saved at $filePath");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Capture The Moments'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () {
                CaptureAndSaveImage();
              },
              icon: const Icon(
                Icons.camera,
                size: 70,
                
              )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Gallary();
                }));
              },
              child: Text('Gallary'))
        ]),
      ),
    );
  }
}
