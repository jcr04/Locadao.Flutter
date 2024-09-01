import 'package:flutter/material.dart';

class AgenciaCardWidget extends StatelessWidget {
  final String title;
  final String id;
  final String endereco;
  final String telefone;
  final String numeroVeiculos;
  final String? aluguelInfo;
  final Color gradientStartColor;
  final Color gradientEndColor;

  const AgenciaCardWidget({
    super.key,
    required this.title,
    required this.id,
    required this.endereco,
    required this.telefone,
    required this.numeroVeiculos,
    this.aluguelInfo,
    this.gradientStartColor = Colors.deepPurple,
    this.gradientEndColor = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
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
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (aluguelInfo == null) ...[
              SizedBox(height: screenHeight * 0.01),
              Text(
                'ID: $id',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
              Text(
                'Endereço: $endereco',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
              Text(
                'Telefone: $telefone',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
              Text(
                'Número de Veículos: $numeroVeiculos',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
            ] else ...[
              SizedBox(height: screenHeight * 0.01),
              Text(
                aluguelInfo!,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
