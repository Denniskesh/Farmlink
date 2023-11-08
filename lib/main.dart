import 'package:farmlink/services/auth/auth_gate.dart';
import 'package:farmlink/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'farmlink_themes.dart';
import 'services/tab_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Farmlinkapp());
}

class Farmlinkapp extends StatelessWidget {
  const Farmlinkapp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = FarmlinkTheme.light();
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => AuthService())
        ],
        child: const AuthGate(),
      ),
    );
  }
}
