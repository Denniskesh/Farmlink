import 'package:flutter/material.dart';

class MyEquipmentPage extends StatelessWidget {
  const MyEquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/empty_list.png'),
              ),
            ),
            Text(
              'No Equipment',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Tap the + button to add your equipment to the platform',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
