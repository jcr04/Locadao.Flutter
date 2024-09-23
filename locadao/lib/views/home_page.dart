import 'package:flutter/material.dart';
import 'package:locadao/views/cliente_create_view.dart';
import 'package:locadao/views/cliente_list_view.dart';
import 'package:locadao/views/veiculo_list_view.dart';
import 'package:locadao/views/agencia_list_view.dart';
import 'package:locadao/views/aluguel_list_view.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:locadao/widgets/menu_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double headerHeight = screenWidth * 0.1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ImageHeaderWidget(
                imagePath: 'lib/assets/locadao.png',
                height: headerHeight,
                backgroundColor: Colors.deepPurple,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.07),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.035,
                    mainAxisSpacing: screenWidth * 0.035,
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
                      MenuCardWidget(
                        title: 'Clientes',
                        icon: Icons.person,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClienteListView()),
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
          Positioned(
            top: headerHeight - 5.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClienteCreateView()),
                );
              },
              tooltip: 'Criar Cliente',
              child: const Icon(Icons.person_add),
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
