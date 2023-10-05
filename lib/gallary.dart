import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Gallary extends StatefulWidget {
  const Gallary({super.key});

  @override
  State<Gallary> createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {
  List<File> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    _loadImageFiles();
  }

  Future<void> _loadImageFiles() async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory('${appDir.path}/images');
    if (imagesDirectory.existsSync()) {
      final imageFiles = imagesDirectory
          .listSync()
          .where((file) => file is File)
          .cast<File>()
          .toList();
      setState(() {
        _imageFiles = imageFiles;
      });
    }
  }

  Future<void> deleteImageFile(File imageFile) async {
    await imageFile.delete();
    _loadImageFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Gallery'),
      ),
      body: _imageFiles.isNotEmpty ?
       GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
        itemCount: _imageFiles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Do you ??'),
                      content: const Text('Do your want to delete this image'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              deleteImageFile(_imageFiles[index]);
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"))
                      ],
                    );
                  });
            },
            child: Image.file(
              _imageFiles[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ):Center(
        child: const Text('No images to show'),
      )
      
    );
  }
}
