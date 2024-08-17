import 'package:flutter/material.dart';

class ImageHeaderWidget extends StatelessWidget {
  final String imagePath;
  final double height;
  final Color backgroundColor;

  const ImageHeaderWidget({
    super.key,
    required this.imagePath,
    this.height = 200.0,
    this.backgroundColor = Colors.blue, // Define a cor de fundo como azul
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: backgroundColor, // Cor de fundo azul
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
