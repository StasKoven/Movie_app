import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
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
          _buildHelpCategory(
            context,
            'Frequently Asked Questions',
            Icons.help_outline,
            [
              _HelpItem('How do I search for movies?', 'Tap the search icon in the top right corner...'),
              _HelpItem('How to add movies to favorites?', 'Tap the heart icon on any movie card...'),
              _HelpItem('How to change my password?', 'Go to Account Settings > Change Password...'),
              _HelpItem('How to sign out?', 'Open your profile and tap Sign Out button...'),
            ],
          ),
          const SizedBox(height: 24),
          _buildContactCard(
            'Contact Support',
            'Need help? Contact us',
            Icons.email,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email: support@moviediscovery.com')),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            'Report a Bug',
            'Found an issue? Let us know',
            Icons.bug_report,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bug report form coming soon')),
              );
            },
          ),
          const SizedBox(height: 24),
          _buildInfoSection(
            'About',
            [
              _InfoItem('Version', '1.0.0'),
              _InfoItem('Build', '100'),
              _InfoItem('Terms of Service', 'View', isLink: true),
              _InfoItem('Privacy Policy', 'View', isLink: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCategory(
    BuildContext context,
    String title,
    IconData icon,
    List<_HelpItem> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.background),
          ...items.map((item) => _buildFAQTile(context, item)),
        ],
      ),
    );
  }

  Widget _buildFAQTile(BuildContext context, _HelpItem item) {
    return ExpansionTile(
      title: Text(
        item.question,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconColor: AppColors.primary,
      collapsedIconColor: AppColors.textSecondary,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            item.answer,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
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
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.textSecondary,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoSection(String title, List<_InfoItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.background),
          ...items.map((item) => ListTile(
                title: Text(
                  item.label,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
                trailing: Text(
                  item.value,
                  style: TextStyle(
                    color: item.isLink ? AppColors.primary : AppColors.textSecondary,
                    decoration: item.isLink ? TextDecoration.underline : null,
                  ),
                ),
                onTap: item.isLink
                    ? () {
                      }
                    : null,
              )),
        ],
      ),
    );
  }
}

class _HelpItem {
  final String question;
  final String answer;

  _HelpItem(this.question, this.answer);
}

class _InfoItem {
  final String label;
  final String value;
  final bool isLink;

  _InfoItem(this.label, this.value, {this.isLink = false});
}
