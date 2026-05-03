import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../auth/login_screen.dart';
import '../earnings/earnings_screen.dart';
import '../schedule/schedule_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Demo palmist data
  final Map<String, dynamic> _palmistData = {
    'name': 'Pandit Ramesh Sharma',
    'email': 'ramesh.sharma@palmist.com',
    'phone': '+91 98765 43210',
    'bio':
        'Expert palmist with 15 years of experience in Vedic palmistry. Specialized in career, relationships, and spiritual guidance.',
    'experience': 15,
    'rating': 4.8,
    'totalRatings': 124,
    'totalConsultations': 248,
    'totalEarnings': 120000.0,
    'isVerified': true,
    'status': 'online',
    'specializations': [
      'Career & Finance',
      'Love & Relationships',
      'Spiritual Growth'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: _showEditProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),

            // Stats Row
            _buildStatsRow(),

            // Specializations
            _buildSpecializations(),

            // Menu Items
            _buildMenuSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, Color(0xFF7B52C1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white24,
                child: Text('🧿', style: TextStyle(fontSize: 44)),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.onlineColor,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.circle, color: Colors.white, size: 10),
                ),
              ),
              if (_palmistData['isVerified'] as bool)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified,
                        color: Colors.white, size: 14),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _palmistData['name'] as String,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _palmistData['email'] as String,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: AppTheme.accentColor, size: 16),
              const SizedBox(width: 4),
              Text(
                '${_palmistData['rating']} (${_palmistData['totalRatings']} reviews)',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _palmistData['bio'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _StatItem(
            value: '${_palmistData['totalConsultations']}',
            label: 'Sessions',
            icon: '📋',
          ),
          _StatItem(
            value: '${_palmistData['experience']}y',
            label: 'Experience',
            icon: '⭐',
          ),
          _StatItem(
            value:
                '₹${((_palmistData['totalEarnings'] as double) / 1000).toStringAsFixed(0)}K',
            label: 'Earned',
            icon: '💰',
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializations() {
    final specs = _palmistData['specializations'] as List<String>;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specializations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: specs
                .map((s) => Chip(
                      label: Text(s,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.primaryColor)),
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      side: BorderSide(
                          color: AppTheme.primaryColor.withOpacity(0.3)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _MenuCard(items: [
            _MenuItem(
              icon: Icons.calendar_month_outlined,
              label: 'Manage Schedule',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScheduleScreen()),
              ),
            ),
            _MenuItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Earnings & Payouts',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EarningsScreen()),
              ),
            ),
            _MenuItem(
              icon: Icons.star_outline,
              label: 'Reviews & Ratings',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 12),
          _MenuCard(items: [
            _MenuItem(
              icon: Icons.notifications_outlined,
              label: 'Notification Settings',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.lock_outline,
              label: 'Change Password',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.help_outline,
              label: 'Help & Support',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 12),
          _MenuCard(items: [
            _MenuItem(
              icon: Icons.logout,
              label: 'Logout',
              color: AppTheme.errorColor,
              onTap: _handleLogout,
            ),
          ]),
          const SizedBox(height: 24),
          const Text(
            'Palmist Console v1.0.0',
            style: TextStyle(color: AppTheme.textHint, fontSize: 12),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showEditProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _palmistData['name'] as String,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _palmistData['phone'] as String,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: _palmistData['bio'] as String,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final String icon;

  const _StatItem(
      {required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.primaryColor)),
          Text(label,
              style:
                  const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final List<_MenuItem> items;

  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon,
                    color: item.color ?? AppTheme.textSecondary),
                title: Text(item.label,
                    style: TextStyle(
                        color: item.color ?? AppTheme.textPrimary,
                        fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppTheme.textSecondary),
                onTap: item.onTap,
              ),
              if (i < items.length - 1) const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuItem(
      {required this.icon,
      required this.label,
      required this.onTap,
      this.color});
}
