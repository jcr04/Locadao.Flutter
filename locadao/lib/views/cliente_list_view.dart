import 'package:flutter/material.dart';
import 'package:locadao/controllers/cliente_controller.dart';
import 'package:locadao/models/cliente.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:locadao/widgets/Vehicle_feature_card_widget.dart';

class ClienteListView extends StatefulWidget {
  const ClienteListView({super.key});

  @override
  _ClienteListViewState createState() => _ClienteListViewState();
}

class _ClienteListViewState extends State<ClienteListView> {
  final ClienteController _controller = ClienteController();
  late Future<List<Cliente>> _clientes;

  @override
  void initState() {
    super.initState();
    _clientes = _controller.getClientesDisponiveis();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes Disponíveis'),
      ),
      body: Column(
        children: [
          ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
          ),
          Expanded(
            child: FutureBuilder<List<Cliente>>(
              future: _clientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum cliente encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var cliente = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: 16.0,
                        ),
                        child: VehicleFeatureCardWidget(
                          icon: Icons.person,
                          title: 'Cliente: ${cliente.nome}',
                          subtitle: 'Email: ${cliente.email}',
                          gradientStartColor: Colors.deepPurple,
                          gradientEndColor: Colors.purple,
                          onTap: () {},
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
