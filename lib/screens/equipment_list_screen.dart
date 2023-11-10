import 'package:farmlink/services/equipment_manager.dart';
import 'package:flutter/material.dart';

class EquipmentListPage extends StatelessWidget {
  const EquipmentListPage({super.key, required EquipmentManager manager});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Equipment list screen'),
    );
  }
}
