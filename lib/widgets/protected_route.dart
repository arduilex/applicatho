import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/auth_screen.dart';
import '../utils/constants.dart';

/// Widget qui protège une route en vérifiant l'authentification
class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Afficher un indicateur de chargement pendant la vérification
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }

        // Si l'utilisateur n'est pas connecté, rediriger vers l'écran d'authentification
        if (!snapshot.hasData || snapshot.data == null) {
          return const AuthScreen();
        }

        final user = snapshot.data!;
        // Vérifier si l'email est vérifié
        if (!user.emailVerified) {
          return const AuthScreen();
        }

        // Si l'utilisateur est connecté et l'email est vérifié, afficher le widget enfant
        return child;
      },
    );
  }
}
