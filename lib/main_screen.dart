import 'package:farmlink/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'screens/equipment_screen.dart';
import 'services/tab_manager.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static List<Widget> pages = <Widget>[
    const HomePage(),
    const OrderPage(),
    const EquipmentPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        body: IndexedStack(
          index: tabManager.selectedTab,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: tabManager.selectedTab,
          onTap: (index) {
            tabManager.goToTab(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'My Equipment',
            ),
          ],
        ),
      );
    });
  }
}
