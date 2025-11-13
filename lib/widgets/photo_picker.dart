import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatefulWidget {
  final Function(String) onPhotoSelected;

  const PhotoPicker({
    Key? key,
    required this.onPhotoSelected, String? initialImagePath,
  }) : super(key: key);

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  String? _imagePath;
  Uint8List? _imageBytes; // For web platform
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        if (kIsWeb) {
          // On web, read as bytes
          _imageBytes = await image.readAsBytes();
          setState(() {
            _imagePath = image.name; // Store name for reference
          });
          widget.onPhotoSelected(image.name);
        } else {
          // On mobile/desktop, use path
          setState(() {
            _imagePath = image.path;
          });
          widget.onPhotoSelected(image.path);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
            border: Border.all(
              color: const Color(0xFF7C3AED),
              width: 3,
            ),
          ),
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    if (kIsWeb && _imageBytes != null) {
      // Display image from bytes on web
      return ClipOval(
        child: Image.memory(
          _imageBytes!,
          fit: BoxFit.cover,
          width: 130,
          height: 130,
        ),
      );
    } else if (!kIsWeb && _imagePath != null) {
      // Display image from file on mobile
      return ClipOval(
        child: Image.file(
          File(_imagePath!),
          fit: BoxFit.cover,
          width: 130,
          height: 130,
        ),
      );
    } else {
      // Placeholder when no image selected
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            size: 40,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 8),
          Text(
            'Add Photo',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      );
    }
  }
}