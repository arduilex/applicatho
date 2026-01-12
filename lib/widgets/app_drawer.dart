import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../screens/home_screen.dart';
import '../screens/church_map_screen.dart';
import '../screens/agenda_screen.dart';
import '../screens/prayer_screen.dart';
import '../providers/auth_provider.dart' show AppAuthProvider;

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<AppAuthProvider>(
            builder: (context, authProvider, child) {
              return DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.church,
                      size: 48,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppStrings.appName,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (authProvider.email != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Connecté: ${authProvider.email}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primary),
            title: const Text(AppStrings.home),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.map, color: AppColors.primary),
            title: const Text(AppStrings.churchMap),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChurchMapScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: AppColors.primary),
            title: const Text(AppStrings.agenda),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AgendaScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book, color: AppColors.primary),
            title: const Text(AppStrings.prayer),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PrayerScreen()),
              );
            },
          ),
          const Divider(),
          Consumer<AppAuthProvider>(
            builder: (context, authProvider, child) {
              return ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text('Déconnexion'),
                onTap: () async {
                  Navigator.pop(context);
                  await authProvider.signOut();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
