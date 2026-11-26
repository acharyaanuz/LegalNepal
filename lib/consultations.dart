import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _preferredMethod;
  DateTime? _preferredDate;
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

  // Sample lawyers
  final List<Lawyer> _availableLawyers = [
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
  void initState() {
    super.initState();
    _preferredDate = DateTime.now().add(const Duration(days: 7));
    _dateController.text = _formatDate(_preferredDate!);
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation Request'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lawyer selection
              DropdownButtonFormField<Lawyer>(
                decoration: InputDecoration(
                  labelText: 'Select Lawyer',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                initialValue: _availableLawyers.isNotEmpty ? _availableLawyers[0] : null,
                items: _availableLawyers.map((Lawyer lawyer) {
                  return DropdownMenuItem(
                    value: lawyer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.person, size: 20),
                          const SizedBox(width: 8),
                          Text(lawyer.name),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (Lawyer? newValue) {
                  setState(() {});
                },
                validator: (value) =>
                    value == null ? 'Please select a lawyer' : null,
              ),
              const SizedBox(height: 24),

              // Category selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Legal Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.folder),
                ),
                initialValue: _selectedCategory,
                items: const [
                  DropdownMenuItem(
                    value: 'family',
                    child: Text('Family Law'),
                  ),
                  DropdownMenuItem(
                    value: 'criminal',
                    child: Text('Criminal Law'),
                  ),
                  DropdownMenuItem(
                    value: 'property',
                    child: Text('Property & Land'),
                  ),
                  DropdownMenuItem(
                    value: 'business',
                    child: Text('Business & Corporate'),
                  ),
                  DropdownMenuItem(
                    value: 'civil',
                    child: Text('Civil Law'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() => _selectedCategory = newValue);
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 24),

              // Preferred method
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Consultation Method',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.video_call),
                ),
                initialValue: _preferredMethod,
                items: const [
                  DropdownMenuItem(
                    value: 'in-person',
                    child: Text('In-person'),
                  ),
                  DropdownMenuItem(
                    value: 'online',
                    child: Text('Online'),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() => _preferredMethod = newValue);
                },
                validator: (value) => value == null ? 'Please select a method' : null,
              ),
              const SizedBox(height: 24),

              // Preferred date
              ListTile(
                title: const Text('Preferred Date'),
                trailing: Text(
                  _dateController.text,
                  style: const TextStyle(color: AppColors.secondary),
                ),
                onTap: _pickDate,
              ),
              const SizedBox(height: 24),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Additional Notes (optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: 'Any specific details about your case...',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                maxLines: 3,
                validator: (value) =>
                    value != null && value.length > 500 ? 'Maximum 500 characters' : null,
              ),
              const SizedBox(height: 32),

              // Submit button
              ElevatedButton(
                onPressed: _submitConsultation,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Submit Consultation Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _preferredDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _preferredDate) {
      setState(() {
        _preferredDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  void _submitConsultation() {
    if (_formKey.currentState?.validate() ?? false) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Consultation request submitted successfully!'),
          backgroundColor: AppColors.primary,
        ),
      );
      // Navigate back or reset form
      // Navigator.pop(context);
    }
  }
}