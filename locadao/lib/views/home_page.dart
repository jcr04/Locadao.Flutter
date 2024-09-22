import 'package:flutter/material.dart';
import 'package:locadao/views/veiculo_list_view.dart';
import 'package:locadao/views/agencia_list_view.dart';
import 'package:locadao/views/aluguel_list_view.dart'; // Importar a nova tela
import 'package:locadao/widgets/logo_header.dart';
import 'package:locadao/widgets/menu_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: isPortrait ? screenHeight * 0.10 : screenHeight * 0.15,
            backgroundColor: Colors.deepPurple,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: GridView.count(
                crossAxisCount: isPortrait ? 2 : 3,
                crossAxisSpacing: screenWidth * 0.035,
                mainAxisSpacing: screenHeight * 0.025,
                children: <Widget>[
                  MenuCardWidget(
                    title: 'Agências',
                    icon: Icons.location_city,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgenciaListView()),
                      );
                    },
                  ),
                  MenuCardWidget(
                    title: 'Veículos',
                    icon: Icons.directions_car,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VeiculoListView()),
                      );
                    },
                  ),
                  MenuCardWidget(
                    title: 'Aluguéis',
                    icon: Icons.car_rental,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AluguelListView()),
                      );
                    },
                  ),
                  // Outros botões podem ser adicionados aqui
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          minimumSize: const Size(double.infinity, 60),
        ),
      ),
    );
  }
}
