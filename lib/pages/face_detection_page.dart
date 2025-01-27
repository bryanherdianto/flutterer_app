import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FaceDetectionPage extends StatelessWidget {
  final List<Rect> rect;
  final ui.Image? imageFile;

  const FaceDetectionPage({
    super.key,
    required this.rect,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple[900],
        title: const Text(
          "Result",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: imageFile != null
            ? FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: imageFile!.width.toDouble(),
                  height: imageFile!.height.toDouble(),
                  child: CustomPaint(
                    painter: FacePainter(rect: rect, imageFile: imageFile!),
                  ),
                ),
              )
            : const Center(child: Text("No image loaded")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {},
        child: const Icon(Icons.save_alt, color: Colors.white),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final List<Rect> rect;
  final ui.Image imageFile;

  FacePainter({required this.rect, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(imageFile, Offset.zero, Paint());

    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0;

    for (final r in rect) {
      canvas.drawRect(r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
