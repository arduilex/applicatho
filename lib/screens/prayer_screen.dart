import 'package:flutter/material.dart';
import '../models/prayer.dart';
import '../models/verse.dart';
import '../services/firebase_service.dart';
import '../widgets/app_drawer.dart';
import '../utils/constants.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> with SingleTickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.prayer),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.secondary,
          labelColor: AppColors.white,
          tabs: const [
            Tab(text: AppStrings.prayers),
            Tab(text: AppStrings.verses),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPrayersTab(),
          _buildVersesTab(),
        ],
      ),
    );
  }

  Widget _buildPrayersTab() {
    return StreamBuilder<List<Prayer>>(
      stream: _firebaseService.getPrayers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final prayers = snapshot.data ?? [];
        if (prayers.isEmpty) {
          return const Center(
            child: Text('Aucune prière disponible'),
          );
        }

        final groupedPrayers = _groupPrayersByCategory(prayers);

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: groupedPrayers.keys.length,
          itemBuilder: (context, index) {
            final category = groupedPrayers.keys.elementAt(index);
            final categoryPrayers = groupedPrayers[category]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                ...categoryPrayers.map((prayer) => _buildPrayerCard(prayer)),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      },
    );
  }

  Map<String, List<Prayer>> _groupPrayersByCategory(List<Prayer> prayers) {
    Map<String, List<Prayer>> grouped = {};
    for (var prayer in prayers) {
      if (!grouped.containsKey(prayer.category)) {
        grouped[prayer.category] = [];
      }
      grouped[prayer.category]!.add(prayer);
    }
    return grouped;
  }

  Widget _buildPrayerCard(Prayer prayer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          prayer.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        leading: const Icon(Icons.menu_book, color: AppColors.primary),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Text(
              prayer.text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersesTab() {
    return StreamBuilder<List<Verse>>(
      stream: _firebaseService.getAllVerses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final verses = snapshot.data ?? [];
        if (verses.isEmpty) {
          return const Center(
            child: Text('Aucun verset disponible'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: verses.length,
          itemBuilder: (context, index) {
            final verse = verses[index];
            return _buildVerseCard(verse);
          },
        );
      },
    );
  }

  Widget _buildVerseCard(Verse verse) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondary.withOpacity(0.1),
              AppColors.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                verse.reference,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '"${verse.text}"',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
