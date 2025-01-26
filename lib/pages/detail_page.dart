import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedTool = "";
  String resultText = "";

  late File pickedImage;
  var imageFile;
  bool isImageLoaded = false;

  getImageFromGallery() async {
    var tempStore = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
    });
  }

  readTextFromImage() async {
    final inputImage = InputImage.fromFile(pickedImage);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();

    resultText = recognisedText.text;

    setState(() {
      print(resultText);
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedTool = ModalRoute.of(context)?.settings.arguments?.toString() ?? '';
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple[900],
        title: Text(
          selectedTool,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  const PopupMenuItem<String>(
                    value: 'Use Camera',
                    child: Text('Use Camera'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Get from Gallery',
                    child: Text('Get from Gallery'),
                  ),
                ],
              ).then((value) {
                if (value == 'Use Camera') {
                  // Handle camera action
                } else if (value == 'Get from Gallery') {
                  getImageFromGallery();
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          isImageLoaded
              ? Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(pickedImage),
                      fit: BoxFit.contain,
                    ),
                  )
                ),
              )
              : Container(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: readTextFromImage,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
