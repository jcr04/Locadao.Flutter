import 'package:flutter/material.dart';

class ImageHeaderWidget extends StatelessWidget {
  final String imagePath;
  final double height;
  final Color backgroundColor;

  const ImageHeaderWidget({
    super.key,
    required this.imagePath,
    this.height = 50.0,
    this.backgroundColor = const Color.fromARGB(255, 70, 17, 131),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: backgroundColor,
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
