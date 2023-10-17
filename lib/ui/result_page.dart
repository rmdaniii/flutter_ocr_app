import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String ocrResult;

   ResultPage({required this.ocrResult});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Scanning Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ocrResult),
          ],
        ),
      ),
    );
  }
}
