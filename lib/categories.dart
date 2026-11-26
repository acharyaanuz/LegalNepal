import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class LegalCategoriesScreen extends StatefulWidget {
  const LegalCategoriesScreen({super.key});

  @override
  State<LegalCategoriesScreen> createState() => _LegalCategoriesScreenState();
}

class _LegalCategoriesScreenState extends State<LegalCategoriesScreen> {
  // Map category titles to icon data
  IconData _getIconForCategory(String title) {
    switch (title) {
      case 'Family Law':
        return Icons.family_restroom;
      case 'Criminal Law':
        return Icons.gavel;
      case 'Property & Land Law':
        return Icons.home_work;
      case 'Business & Corporate':
        return Icons.business_center;
      case 'Employment Law':
        return Icons.work;
      case 'Civil Law':
        return Icons.article;
      case 'Immigration Law':
        return Icons.flight_takeoff;
      case 'Consumer Rights':
        return Icons.shopping_cart;
      default:
        return Icons.folder;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legal Categories')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final cat = _categories[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // Navigate to lawyer search with category filter
                  Navigator.pushNamed(context, '/lawyer-search');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_getIconForCategory(cat.title), size: 48, color: AppColors.primary),
                    const SizedBox(height: 8),
                    Text(cat.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(cat.description ?? '', style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final List<Category> _categories = const [
    Category(id: 'family', title: 'Family Law', description: 'Divorce, custody, inheritance'),
    Category(id: 'criminal', title: 'Criminal Law', description: 'Offences & defence'),
    Category(id: 'property', title: 'Property & Land Law', description: 'Ownership, leases'),
    Category(id: 'business', title: 'Business & Corporate', description: 'Company formation, contracts'),
    Category(id: 'employment', title: 'Employment Law', description: 'Labour rights, contracts'),
    Category(id: 'civil', title: 'Civil Law', description: 'Disputes, torts'),
    Category(id: 'immigration', title: 'Immigration Law', description: 'Visas, residency'),
    Category(id: 'consumer', title: 'Consumer Rights', description: 'Goods, services, refunds'),
  ];
}