import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class SocialFooter extends StatelessWidget {
  const SocialFooter({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        border: const Border(
          top: BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: AppColors.primary,
                  size: 32,
                ),
                onPressed: () => _launchUrl(SocialLinks.whatsapp),
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: AppColors.primary,
                  size: 32,
                ),
                onPressed: () => _launchUrl(SocialLinks.instagram),
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: AppColors.primary,
                  size: 32,
                ),
                onPressed: () => _launchUrl(SocialLinks.youtube),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(AppStrings.legalNotice),
                  content: const SingleChildScrollView(
                    child: Text(
                      'Application développée pour la communauté catholique/chrétienne.\n\n'
                      'Éditeur: BDPI\n'
                      'Contact: [votre email]\n\n'
                      'Les données personnelles ne sont pas collectées par cette application.\n\n'
                      'Tous droits réservés.',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fermer'),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              AppStrings.legalNotice,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
