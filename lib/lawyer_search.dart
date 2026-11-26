import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class LawyerSearchScreen extends StatefulWidget {
  const LawyerSearchScreen({super.key});

  @override
  State<LawyerSearchScreen> createState() => _LawyerSearchScreenState();
}

class _LawyerSearchScreenState extends State<LawyerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  bool _isLoading = false;

  // Sample lawyers data
  final List<Lawyer> _lawyers = [
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
    Lawyer(
      id: '3',
      name: 'Adv. Sita Karki',
      specialization: 'Property Law',
      experienceYears: 5,
      location: 'Biratnagar',
      languages: ['Nepali', 'English'],
      fee: 3000,
      verified: false,
      avatarUrl: '',
    ),
    Lawyer(
      id: '4',
      name: 'Adv. Bishal Thapa',
      specialization: 'Business Law',
      experienceYears: 10,
      location: 'Kathmandu',
      languages: ['Nepali', 'English'],
      fee: 4500,
      verified: true,
      avatarUrl: '',
    ),
  ];

  List<Lawyer> get _filteredLawyers {
    if (_selectedCategory == null || _selectedCategory == 'All') return _lawyers;
    return _lawyers.where((lawyer) => lawyer.specialization == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Lawyer'),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search lawyers...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => _searchController.clear());
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // Category filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildCategoryFilter('All'),
                _buildCategoryFilter('Family Law'),
                _buildCategoryFilter('Criminal Law'),
                _buildCategoryFilter('Property Law'),
                _buildCategoryFilter('Business Law'),
                _buildCategoryFilter('Employment Law'),
                _buildCategoryFilter('Civil Law'),
                _buildCategoryFilter('Immigration Law'),
                _buildCategoryFilter('Consumer Rights'),
              ],
            ),
          ),

          // Lawyers list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredLawyers.isEmpty
                    ? const Center(
                        child: Text('No lawyers found. Try different search criteria.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: _filteredLawyers.length,
                        itemBuilder: (context, index) {
                          final lawyer = _filteredLawyers[index];
                          return _LawyerCard(lawyer: lawyer);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(String label) {
    final isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primary.withOpacity(0.2),
        backgroundColor: AppColors.primary.withOpacity(0.1),
        onSelected: (_) {
          setState(() => _selectedCategory = label);
          _searchController.clear();
        },
      ),
    );
  }
}

class _LawyerCard extends StatelessWidget {
  final Lawyer lawyer;

  const _LawyerCard({required this.lawyer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to lawyer detail screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundImage: lawyer.avatarUrl.isNotEmpty
                    ? NetworkImage(lawyer.avatarUrl)
                    : null,
                child: lawyer.avatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 24)
                    : null,
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
              // Fee and verified badge
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
                  const SizedBox(height: 4),
                  if (lawyer.verified)
                    Text(
                      'Verified',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}