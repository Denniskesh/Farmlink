import 'package:farmlink/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farmlink/main_screen.dart';
import 'package:provider/provider.dart';
import '../../screens/onboarding.dart';
import '../tab_manager.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator or splash screen while waiting for authentication
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            User? user = snapshot.data;

            // Check if the user is new
            bool isNewUser =
                user?.metadata.creationTime == user?.metadata.lastSignInTime;
            TabManager tabManager =
                Provider.of<TabManager>(context, listen: false);
            tabManager.setNewUserStatus(isNewUser);

            if (isNewUser) {
              // Redirect to the onboarding screen for new users
              return const OnboardingScreen();
            } else {
              // User is not new, show the main screen
              return const MainScreen();
            }
          } else {
            // User is not authenticated, show login or register screen
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
