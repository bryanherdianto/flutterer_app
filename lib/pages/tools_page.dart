import 'package:flutter/material.dart';
import 'package:flutterer_app/pages/detail_page.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final List<Map<String, Object>> toolsList = [
    {"name": "Text Scanner", "icon": Icons.text_fields},
    {"name": "Barcode Scanner", "icon": Icons.qr_code_scanner},
    {"name": "Label Scanner", "icon": Icons.label},
    {"name": "Face Detection", "icon": Icons.face},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns per row
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1, // Make it a square
          ),
          itemCount: toolsList.length,
          itemBuilder: (context, index) {
            final tool = toolsList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                    settings: RouteSettings(arguments: tool["name"]),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(tool["icon"] as IconData, size: 50, color: Colors.purple[900]),
                    const SizedBox(height: 10),
                    Text(
                      tool["name"] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}
