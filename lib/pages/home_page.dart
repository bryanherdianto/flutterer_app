import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function(int)? onPressed;

  const HomePage({super.key, this.onPressed});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> toolsList = [
    {"name": "Text Scanner", "icon": Icons.text_fields, "description": "Extract text from images."},
    {"name": "Barcode Scanner", "icon": Icons.qr_code_scanner, "description": "Scan barcodes in images."},
    {"name": "Label Scanner", "icon": Icons.label, "description": "Detect labels in images."},
    {"name": "Face Detection", "icon": Icons.face, "description": "Detect faces in images."},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            "Welcome to ML Kit Tools!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple[900],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Explore advanced features like Face Recognition, Text Recognition, Barcode Scanning, and more. Use the bottom menu to navigate.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          const SizedBox(height: 24),
          Icon(Icons.settings, size: 100, color: Colors.purple[900]),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              widget.onPressed?.call(2);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[900],
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text("Get Started with Tools",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: toolsList.length,
              itemBuilder: (context, index) {
                final tool = toolsList[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(tool["icon"], color: Colors.purple[900]),
                    title: Text(tool["name"]),
                    subtitle: Text(tool["description"]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
