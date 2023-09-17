import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;
  void _takePictureFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) return;

    setState(() {
      _takenImage = File(pickedImage.path);
    });

    widget.onPickImage(_takenImage!);
  }

  void _takePictureFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedImage == null) return;

    setState(() {
      _takenImage = File(pickedImage.path);
    });

     widget.onPickImage(_takenImage!);
  }

  void _selectAgain() {
    setState(() {
      _takenImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        const SizedBox(
          height: 90,
        ),
        FilledButton.icon(
          onPressed: _takePictureFromCamera,
          icon: const Icon(Icons.camera),
          label: const Text(
            'Take picture',
            style: TextStyle(fontSize: 25),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        FilledButton.icon(
          onPressed: _takePictureFromGallery,
          icon: const Icon(Icons.camera),
          label: const Text(
            'Select Picture From Gallery',
            style: TextStyle(fontSize: 25),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
    if (_takenImage != null) {
      content = GestureDetector(
          onTap: _selectAgain,
          child: Image.file(
            _takenImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ));
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      height: 350,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
