import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_equipment_screen_empty.dart';
import 'add_owner_detail_screen.dart';
import 'package:farmlink/services/equipment_manager.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<EquipmentManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OwnerDetailPage(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
      body: buildEquipmentScreen(),
    );
  }

  Widget buildEquipmentScreen() {
    return Consumer<EquipmentManager>(builder: (context, manager, child) {
      return const MyEquipmentPage();
    });
  }
}
