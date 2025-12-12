import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _newMovies = true;
  bool _recommendations = true;
  bool _updates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 8),
          const Text(
            'General',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            'Push Notifications',
            'Receive push notifications on your device',
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),
          _buildSwitchTile(
            'Email Notifications',
            'Receive notifications via email',
            _emailNotifications,
            (value) => setState(() => _emailNotifications = value),
          ),
          const SizedBox(height: 24),
          const Text(
            'Content',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            'New Movies',
            'Get notified about new movie releases',
            _newMovies,
            (value) => setState(() => _newMovies = value),
          ),
          _buildSwitchTile(
            'Recommendations',
            'Receive personalized movie recommendations',
            _recommendations,
            (value) => setState(() => _recommendations = value),
          ),
          _buildSwitchTile(
            'App Updates',
            'Notifications about app updates and features',
            _updates,
            (value) => setState(() => _updates = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
        activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
      ),
    );
  }
}
