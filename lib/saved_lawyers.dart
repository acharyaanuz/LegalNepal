import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class SavedLawyersScreen extends StatefulWidget {
  const SavedLawyersScreen({super.key});

  @override
  State<SavedLawyersScreen> createState() => _SavedLawyersScreenState();
}

class _SavedLawyersScreenState extends State<SavedLawyersScreen> {
  final List<Lawyer> _savedLawyers = [
    Lawyer(
      id: '1',
      name: 'Adv. Anita Sharma',
      specialization: 'Family Law',
      experienceYears: 8,
      location: 'Kathmandu',
      languages: ['Nepali', 'English'],
      fee: 3500,
      verified: true,
      avatarUrl: '',
    ),
    Lawyer(
      id: '2',
      name: 'Adv. Rajesh Patel',
      specialization: 'Criminal Law',
      experienceYears: 12,
      location: 'Pokhara',
      languages: ['Nepali', 'English', 'Hindi'],
      fee: 5000,
      verified: true,
      avatarUrl: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Lawyers'),
        backgroundColor: AppColors.primary,
      ),
      body: _savedLawyers.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: AppColors.textDark),
                  const SizedBox(height: 16),
                  const Text('No saved lawyers yet'),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/lawyer-search');
                    },
                    child: const Text('Find Lawyers'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _savedLawyers.length,
              itemBuilder: (BuildContext itemContext, int index) {
                final lawyer = _savedLawyers[index];
                return _SavedLawyerCard(
                  lawyer: lawyer,
                  onUnsave: () => _unsaveLawyer(itemContext, lawyer),
                );
              },
            ),
    );
  }

  void _unsaveLawyer(BuildContext ctx, Lawyer lawyer) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(content: Text('Lawyer removed from saved list')),
    );
  }
}

class _SavedLawyerCard extends StatelessWidget {
  final Lawyer lawyer;
  final VoidCallback onUnsave;

  const _SavedLawyerCard({required this.lawyer, required this.onUnsave});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to lawyer detail
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Avatar with save status
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: lawyer.avatarUrl.isNotEmpty
                        ? NetworkImage(lawyer.avatarUrl)
                        : null,
                    child: lawyer.avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 24)
                        : null,
                  ),
                  // Save indicator
                  Positioned(
                    right: -4,
                    top: -4,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.bookmark,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lawyer.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 12, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text(
                          '${lawyer.experienceYears} years experience',
                          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lawyer.specialization,
                      style: const TextStyle(fontSize: 12, color: AppColors.secondary),
                    ),
                  ],
                ),
              ),
              // Fee and actions
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs. ${lawyer.fee?.toStringAsFixed(0) ?? 0}/consultation',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => _showConsultationDialog(context, lawyer),
                    icon: const Icon(Icons.chat, size: 16),
                    label: const Text('Consult'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 28),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: onUnsave,
                    child: const Text(
                      'Unsave',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConsultationDialog(BuildContext context, Lawyer lawyer) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Consult ${lawyer.name}'),
        content: const SingleChildScrollView(
          child: ListTile(
            title: Text('Select consultation method and date'),
            subtitle: Text('Choose how and when you\'d like to consult'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/consultations');
            },
            child: const Text('Request Consultation'),
          ),
        ],
      ),
    );
  }
}