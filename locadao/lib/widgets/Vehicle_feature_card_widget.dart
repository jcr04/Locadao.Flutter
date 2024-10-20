// ignore_for_file: file_names

import 'package:flutter/material.dart';

class VehicleFeatureCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color gradientStartColor;
  final Color gradientEndColor;

  const VehicleFeatureCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.gradientStartColor = Colors.deepPurple,
    this.gradientEndColor = Colors.purple,
    required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.30,
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Row(
          children: [
            Icon(
              icon,
              size: screenWidth * 0.08, // Ajustando o tamanho do ícone
              color: Colors.white,
            ),
            SizedBox(width: screenWidth * 0.05),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize:
                          screenWidth * 0.04, // Ajustando o tamanho do texto
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize:
                          screenWidth * 0.035, // Ajustando o tamanho do texto
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
