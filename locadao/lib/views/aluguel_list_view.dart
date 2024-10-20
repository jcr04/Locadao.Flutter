import 'package:flutter/material.dart';
import 'package:locadao/controllers/aluguel_controller.dart';
import 'package:locadao/models/aluguel.dart';
import 'package:locadao/widgets/logo_header.dart';
import 'package:locadao/widgets/Vehicle_feature_card_widget.dart';

class AluguelListView extends StatefulWidget {
  @override
  _AluguelListViewState createState() => _AluguelListViewState();
}

class _AluguelListViewState extends State<AluguelListView> {
  final AluguelController _controller = AluguelController();
  late Future<List<Aluguel>> _alugueis;

  @override
  void initState() {
    super.initState();
    _alugueis = _controller.getAlugueisDisponiveis();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aluguéis Disponíveis'),
      ),
      body: Column(
        children: [
          ImageHeaderWidget(
            imagePath: 'lib/assets/locadao.png',
            height: isPortrait ? screenHeight * 0.15 : screenHeight * 0.2,
          ),
          Expanded(
            child: FutureBuilder<List<Aluguel>>(
              future: _alugueis,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum aluguel encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var aluguel = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: 16.0,
                        ),
                        child: VehicleFeatureCardWidget(
                          icon: Icons.car_rental,
                          title: 'Aluguel ID: ${aluguel.id}',
                          subtitle: 'Status: ${aluguel.status}',
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
