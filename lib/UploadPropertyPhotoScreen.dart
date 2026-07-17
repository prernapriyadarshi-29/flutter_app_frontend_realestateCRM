import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class UploadPropertyPhotoScreen extends StatefulWidget {
  final int propertyId;

  const UploadPropertyPhotoScreen({
    required this.propertyId,
    super.key,
  });

  @override
  State<UploadPropertyPhotoScreen> createState() =>
      _UploadPropertyPhotoScreenState();
}

class _UploadPropertyPhotoScreenState extends State<UploadPropertyPhotoScreen> {
  bool _isUploading = false;

  Future<void> _pickAndUploadPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      setState(() => _isUploading = true);

      final response =
          await ApiService.uploadPropertyPhoto(widget.propertyId, image.path);

      setState(() => _isUploading = false);

      if (response['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo uploaded successfully!')),
        );
         Navigator.pop(context, true); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Upload failed')),
        );
      }
    } catch (e) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Property Photo')),
      body: Center(
        child: _isUploading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _pickAndUploadPhoto,
                child: Text('Pick & Upload Photo'),
              ),
      ),
    );
  }
}