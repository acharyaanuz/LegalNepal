import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Sample user data
  final User _user = User(
    id: '1',
    fullName: 'Ravi Kumar',
    emailOrPhone: 'ravi.kumar@email.com',
    role: 'client',
  );

  // Settings toggles
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user.fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _user.emailOrPhone,
                    style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Account section
            _buildSectionTitle('Account'),
            _buildSettingTile(
              icon: Icons.edit,
              title: 'Edit Profile',
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Navigate to edit profile
              },
            ),
            _buildSettingTile(
              icon: Icons.lock,
              title: 'Change Password',
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Navigate to change password
              },
            ),
            _buildSettingTile(
              icon: Icons.logout,
              title: 'Log Out',
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Show logout confirmation
                _showLogoutDialog();
              },
            ),
            const Divider(height: 32),

            // Legal information section
            _buildSectionTitle('Legal Information'),
            _buildSettingTile(
              icon: Icons.notifications,
              title: 'Notifications',
              trailing: Switch(
                value: _notificationsEnabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setState(() => _notificationsEnabled = value);
                },
              ),
              onTap: () {
                // Toggle notifications on tap
                setState(() => _notificationsEnabled = !_notificationsEnabled);
              },
            ),
            _buildSettingTile(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              trailing: Switch(
                value: _darkModeEnabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setState(() => _darkModeEnabled = value);
                },
              ),
              onTap: () {
                // Toggle dark mode on tap
                setState(() => _darkModeEnabled = !_darkModeEnabled);
              },
            ),
            const Divider(height: 32),

            // App version
            Center(
              child: Text(
                'Version 1.0.0',
                style: const TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
      subtitle: const Text(''),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Navigate back to login
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}