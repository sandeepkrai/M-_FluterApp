import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key, required String title}) : super(key: key);

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  // A variable to store the selected image file
  File? _image;

  // A variable to store the upload status
  String _status = '';

  // A method to pick an image from the gallery or camera using image_picker package
  Future<void> _pickImage(ImageSource source) async {
    // Use the ImagePicker class to get the selected image file
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    // Check if the picked file is not null
    if (pickedFile != null) {
      // Set the image file to the picked file
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // A method to upload the image file to imgcdn.dev using http package
  Future<void> _uploadImage() async {
    // Check if the image file is not null
    if (_image != null) {
      // Set the upload status to loading
      setState(() {
        _status = 'Uploading...';
      });

      // Define the base url and parameters for the API request
      String baseUrl = 'https://imgcdn.dev/upload';
      String apiKey =
          '5386e05a3562c7a8f984e73401540836'; // Replace this with your own API key from imgcdn.dev

      // Construct a multipart request with the image file and the api key
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.files
          .add(await http.MultipartFile.fromPath('file', _image!.path));
      request.fields['key'] = apiKey;

      // Send the request and get the response
      var response = await request.send();

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Get the response stream and decode it as a JSON object
        var data = await response.stream.bytesToString();
        var jsonData = jsonDecode(data);

        // Get the image url from the JSON object
        String imageUrl = jsonData['url'];

        // Set the upload status to success with the image url
        setState(() {
          _status = 'Upload successful: $imageUrl';
        });
      } else {
        // Set the upload status to failure with the status code
        setState(() {
          _status = 'Upload failed: ${response.statusCode}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A widget to display the selected image or a placeholder
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: _image == null
                  ? Center(child: Text('No image selected'))
                  : Image.file(_image!),
            ),
            SizedBox(height: 16.0),
            // A widget to display the upload status or a placeholder
            Text(_status.isEmpty ? 'No upload status' : _status),
            SizedBox(height: 16.0),
            // A row of widgets for the image picker buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // A widget for the gallery button
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text('Gallery'),
                ),
                SizedBox(width: 8.0),
                // A widget for the camera button
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Text('Camera'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // A widget for the upload button
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
