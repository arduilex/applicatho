import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_screen.dart';
import 'screens/church_map_screen.dart';
import 'screens/agenda_screen.dart';
import 'screens/prayer_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/auth_provider.dart' show AppAuthProvider;
import 'services/auth_service.dart';
import 'widgets/protected_route.dart';
import 'utils/constants.dart';

// Uncomment this line after running 'flutterfire configure'
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Note: You need to configure Firebase for your project first
  // Run: flutterfire configure
  // Then uncomment the import above and use DefaultFirebaseOptions.currentPlatform
  try {
    await Firebase.initializeApp(
      // Uncomment this after running flutterfire configure:
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
    debugPrint('Make sure to configure firebase_options.dart with your Firebase config');
    debugPrint('Or run: flutterfire configure');
  }

  // Initialize French locale for dates
  await initializeDateFormatting('fr_FR', null);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppAuthProvider(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        routes: {
          '/churches': (context) => const ProtectedRoute(
                child: ChurchMapScreen(),
              ),
          '/agenda': (context) => const ProtectedRoute(
                child: AgendaScreen(),
              ),
          '/prayers': (context) => const ProtectedRoute(
                child: PrayerScreen(),
              ),
          '/admin': (context) => const ProtectedRoute(
                child: AdminScreen(),
              ),
        },
      ),
    );
  }
}

// Widget qui vérifie l'authentification et redirige vers l'écran approprié
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthProvider>(
      builder: (context, authProvider, child) {
        // Si l'utilisateur est connecté et l'email est vérifié, afficher l'écran d'accueil
        if (authProvider.isAuthenticated && authProvider.isEmailVerified) {
          return const HomeScreen();
        }
        
        // Sinon, afficher l'écran d'authentification
        return const AuthScreen();
      },
    );
  }
}
