import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Panneau d\'administration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          _buildAdminCard(
            context,
            'Saints',
            Icons.person,
            () => Navigator.pushNamed(context, '/admin/saints'),
          ),
          _buildAdminCard(
            context,
            'Versets',
            Icons.menu_book,
            () => Navigator.pushNamed(context, '/admin/verses'),
          ),
          _buildAdminCard(
            context,
            'Événements',
            Icons.event,
            () => Navigator.pushNamed(context, '/admin/events'),
          ),
          _buildAdminCard(
            context,
            'Prières',
            Icons.book,
            () => Navigator.pushNamed(context, '/admin/prayers'),
          ),
          _buildAdminCard(
            context,
            'Églises',
            Icons.church,
            () => Navigator.pushNamed(context, '/admin/churches'),
          ),
          _buildAdminCard(
            context,
            'Membres',
            Icons.people,
            () => Navigator.pushNamed(context, '/admin/members'),
          ),
          _buildAdminCard(
            context,
            'FAQ',
            Icons.question_answer,
            () => Navigator.pushNamed(context, '/admin/faqs'),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 32),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
