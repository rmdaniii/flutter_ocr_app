import 'dart:io';

import 'package:camera_ocr_app/service/AzureOCR%20.dart';
import 'package:camera_ocr_app/utils/ImageHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(CameraOCRApp());
}

class CameraOCRApp extends StatefulWidget {
  @override
  State<CameraOCRApp> createState() => _CameraOCRAppState();
}

class _CameraOCRAppState extends State<CameraOCRApp> {
  AzureOCR azureOCR = AzureOCR(
      apiKey: '2455508f17114e0da4ce85654e40cde5',
      endpoint: 'https://ocr-flutter-app-demo.cognitiveservices.azure.com/');

  String? ocrResult;
  String recognizedText = "";

  String selectedImagePath = "";

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImagePath = pickedImage.path;
        recognizedText = "";
      });
    }
  }

  Future<void> _recognizeText() async {
    if (selectedImagePath != null) {
      final recognizedText = await azureOCR.recognizeText(selectedImagePath);
      setState(() {
        this.recognizedText = recognizedText as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OCR Azure App'),
        ),
        body:  Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(selectedImagePath != null)
                  Image.file(
                    File(selectedImagePath),
                    height: 300,
                    width: 300,
                  ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: const Text('Pick an Image')
                ),
                if (selectedImagePath != null)
                  ElevatedButton(
                    onPressed: _recognizeText,
                    child: const Text('Recognize Text'),
                  ),
                // Add a widget to display recognized text here
                // Display recognized text here
                Text(recognizedText),
              ],
            ),
          )
        ),

      ),
    );
  }
}
