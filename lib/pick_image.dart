import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  List<Filter> filters = presetFiltersList;
  File? imageFile;
  final _picker = ImagePicker();

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) {
      //print('No file picked');
      return;
    }

    imageFile = File(pickedFile.path);
    var fileName = basename(imageFile!.path);
    final bytes = await imageFile!.readAsBytes();

    var image = imageLib.decodeImage(bytes);
    if (image == null) {
      // print('Decoded image is null');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to decode image")));
      return;
    }

    final Map? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          appBarColor: Colors.deepOrange.shade100,
          title: const Text(
            "Apply Filters",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (!mounted) return;

    // print('Returned from filter screen with: $result');

    if (result != null && result.containsKey('image_filtered')) {
      File filteredImage = result['image_filtered'];
      final success = await GallerySaver.saveImage(filteredImage.path);
      if (!mounted) return;

      if (success == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Saved!"),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Icon(Icons.check, color: Colors.green, size: 25),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Failed to save image")));
      }
      if (mounted) {
        setState(() {
          imageFile = filteredImage;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade100,
        title: const Text(
          'FilterSnap',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.4,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: (imageFile == null)
            ? const Text(
                'No image picked!',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                  fontSize: 14,
                ),
              )
            : Image.file(imageFile!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: 'gallery',
            onPressed: () async {
              await pickImage(context, ImageSource.gallery);
            },
            tooltip: 'Pick Image',
            child: const Icon(Icons.image, color: Colors.deepOrange),
          ),
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: () async {
              await pickImage(context, ImageSource.camera);
            },
            tooltip: 'Take Photo',
            child: const Icon(Icons.camera_alt, color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
