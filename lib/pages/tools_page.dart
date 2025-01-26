import 'package:flutter/material.dart';
import 'package:flutterer_app/pages/detail_page.dart';

class ToolsPage extends StatefulWidget {

  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final toolsList = [
    "Text Scanner",
    "Barcode Scanner",
    "Label Scanner",
    "Face Detection",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: toolsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(toolsList[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                    settings: RouteSettings(
                      arguments: toolsList[index],
                    ),
                  )
                );
              }
            ),
          );
        },
      ),
    );
  }
}
