import 'package:flutter/material.dart';

class ImageHeaderWidget extends StatelessWidget {
  final String imagePath;
  final double height;
  final Color backgroundColor;

  const ImageHeaderWidget({
    super.key,
    required this.imagePath,
    this.height = 100.0,
    this.backgroundColor = const Color.fromARGB(255, 70, 17, 131),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            height: height * 0.8,
          ),
        ),
      ),
    );
  }
}
