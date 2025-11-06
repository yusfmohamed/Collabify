import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../config/theme.dart';
import 'dart:math';

class FilePickerField extends StatefulWidget {
  final Function(PlatformFile?) onFileSelected;

  const FilePickerField({
    Key? key,
    required this.onFileSelected,
  }) : super(key: key);

  @override
  State<FilePickerField> createState() => _FilePickerFieldState();
}

class _FilePickerFieldState extends State<FilePickerField> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        withData: true, // Important for web - loads file data in memory
        withReadStream: false, // Set to true if you want stream for large files
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        
        setState(() {
          _selectedFile = file;
        });
        
        widget.onFileSelected(file);
      }
    } catch (e) {
      print('Error picking file: $e');
      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearFile() {
    setState(() {
      _selectedFile = null;
    });
    widget.onFileSelected(null);
  }

  String _getFileSizeString(int bytes, {int decimals = 2}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: AppColors.inputBorder,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.description_outlined,
                      color: AppColors.primaryPurple,
                      size: 26,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedFile?.name ?? 'Upload CV (PDF, Word)',
                          style: _selectedFile != null
                              ? AppTextStyles.input
                              : AppTextStyles.hint,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (_selectedFile != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _getFileSizeString(_selectedFile!.size),
                              style: AppTextStyles.hint.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_selectedFile != null)
                    IconButton(
                      onPressed: _clearFile,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 24,
                      ),
                    )
                  else
                    const Icon(
                      Icons.cloud_upload_outlined,
                      color: AppColors.primaryPurple,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        ),
        
        // File validation info
        if (_selectedFile != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'File selected: ${_selectedFile!.name}',
                    style: AppTextStyles.hint.copyWith(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// Add these imports at the top of your file
