import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:locadao/views/cliente_create_view.dart';
import 'package:locadao/views/create_aluguel_view.dart';
import 'package:locadao/views/create_veiculo_view.dart';
import 'package:locadao/views/cliente_list_view.dart';
import 'package:locadao/views/veiculo_list_view.dart';
import 'package:locadao/views/agencia_list_view.dart';
import 'package:locadao/views/aluguel_list_view.dart';
import 'package:locadao/widgets/menu_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.deepPurple, // Cor de fundo
            height: 200, // Altura da área do cabeçalho
          ),
          Positioned(
            top: 20, // Ajuste a distância do topo conforme necessário
            left: 20, // Ajuste a distância da esquerda conforme necessário
            child: Image.asset('lib/assets/locadao.png',
                height: 150, // Ajuste o tamanho do logo conforme necessário
                fit: BoxFit.cover,
                alignment: Alignment.topLeft),
          ),
          Column(
            children: [
              const SizedBox(
                  height: 200), // Espaço para deixar abaixo do header
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
                                builder: (context) => const AgenciaListView()),
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
                                builder: (context) => const VeiculoListView()),
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
                                builder: (context) => const AluguelListView()),
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
                                builder: (context) => const ClienteListView()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.person_add),
            backgroundColor: Colors.deepPurple,
            label: 'Criar Cliente',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ClienteCreateView()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.directions_car),
            backgroundColor: Colors.deepPurple,
            label: 'Criar Veículo',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateVeiculoView()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.car_rental),
            backgroundColor: Colors.deepPurple,
            label: 'Criar Aluguel',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateAluguelView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
