import 'package:flutter/material.dart';
import 'package:locadao/widgets/Vehicle_feature_card_widget.dart';

class MenuCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17.0),
      child: VehicleFeatureCardWidget(
        icon: icon,
        title: title,
        subtitle: '',
        gradientStartColor: Colors.deepPurple,
        gradientEndColor: Colors.purple,
        onTap: () {},
      ),
    );
  }
}
