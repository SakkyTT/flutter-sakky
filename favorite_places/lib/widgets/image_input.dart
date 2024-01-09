import 'dart:io';
// input/output, yleinen tarkoitus on tiedostojen/kansioiden käyttö

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  // add_place tiedostosta lähetetään funktio, jolla voidaan tallentaa
  // image file sinne (add_place tiedostoon).
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    // Tarkistetaan, saatiinko käyttäjältä kuva
    if (pickedImage == null) {
      // Lopetetaan suoritus, jos ei ole kuvaa
      return;
    }

    // Tallennetaan kuva
    //                      XFile => File
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    // Käytetään funktiota, jolla objekti voidaan lähettää vanhemmalle
    // add_place tiedostoon, tässä tapauksessa
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera_alt_outlined),
      label: const Text('Take a Picture'),
    );

    // Jos kuva on otettu
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
