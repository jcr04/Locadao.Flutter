import 'package:flutter/material.dart';
import 'package:locadao/views/veiculo_list_view.dart';
import 'agencia_list_view.dart';
// import 'aluguel_list_view.dart';
// import 'cliente_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locadão - Menu Principal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton(
              title: 'Agências',
              icon: Icons.location_city,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgenciaListView()),
                );
              },
            ),
            MenuButton(
              title: 'Veículos',
              icon: Icons.directions_car,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VeiculoListView()),
                );
              },
            ),
            // MenuButton(
            //   title: 'Aluguéis',
            //   icon: Icons.car_rental,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AluguelListView()),
            //     );
            //   },
            // ),
            // MenuButton(
            //   title: 'Clientes',
            //   icon: Icons.person,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ClienteListView()),
            //     );
            //   },
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuButton({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 40),
        label: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          minimumSize: const Size(double.infinity, 60),
        ),
      ),
    );
  }
}
