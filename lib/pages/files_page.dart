import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  List<FileObject> objects = [];

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  Future<void> getFiles() async {
    try {
      objects = await _supabaseClient.storage.from('images').list(path: 'uploads');
      setState(() {});
    } catch (e) {
      print("Error fetching files: $e");
    }
  }

  Future<void> deleteFile(String fileName) async {
    try {
      await _supabaseClient.storage.from('images').remove(['uploads/$fileName']);
      setState(() {
        objects.removeWhere((file) => file.name == fileName);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("File deleted successfully"),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print("Error deleting file: $e");
    }
  }

  void _showOptions(BuildContext context, String fileName) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                deleteFile(fileName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                shareFile(fileName);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> shareFile(String fileName) async {
    try {
      final imageUrl = _supabaseClient.storage
          .from('images')
          .getPublicUrl('uploads/$fileName');

      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final directory = Directory.systemTemp.path;
        final file = File('$directory/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        await Share.shareXFiles([XFile(file.path)], text: 'Check out this file!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to download the file for sharing"),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print("Error sharing file: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to share the file"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: objects.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 4,
              ),
              itemCount: objects.length,
              itemBuilder: (context, index) {
                final fileObject = objects[index];
                final imageUrl = _supabaseClient.storage
                    .from('images')
                    .getPublicUrl('uploads/${fileObject.name}');
                return GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  fileObject.name,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert, size: 20),
                                onPressed: () =>
                                    _showOptions(context, fileObject.name),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          backgroundColor: Colors.black,
                          body: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
