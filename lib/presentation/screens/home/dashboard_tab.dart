import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../analysis/hand_analysis_screen.dart';
import '../consultations/consultations_screen.dart';
import '../earnings/earnings_screen.dart';
import '../schedule/schedule_screen.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  String _palmistStatus = 'online';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palmist Console'),
        actions: [
          // Status Toggle
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton<String>(
              onSelected: (value) => setState(() => _palmistStatus = value),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'online',
                  child: Row(children: [
                    Icon(Icons.circle, color: AppTheme.onlineColor, size: 12),
                    SizedBox(width: 8),
                    Text('Online'),
                  ]),
                ),
                const PopupMenuItem(
                  value: 'busy',
                  child: Row(children: [
                    Icon(Icons.circle, color: AppTheme.busyColor, size: 12),
                    SizedBox(width: 8),
                    Text('Busy'),
                  ]),
                ),
                const PopupMenuItem(
                  value: 'offline',
                  child: Row(children: [
                    Icon(Icons.circle, color: AppTheme.offlineColor, size: 12),
                    SizedBox(width: 8),
                    Text('Offline'),
                  ]),
                ),
              ],
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: _palmistStatus == 'online'
                          ? AppTheme.onlineColor
                          : _palmistStatus == 'busy'
                              ? AppTheme.busyColor
                              : AppTheme.offlineColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _palmistStatus[0].toUpperCase() +
                          _palmistStatus.substring(1),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down,
                        color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            _buildGreetingCard(),
            const SizedBox(height: 20),

            // Today's Stats
            _buildTodayStats(),
            const SizedBox(height: 20),

            // Earnings Summary
            _buildEarningsSummary(),
            const SizedBox(height: 20),

            // Upcoming Sessions
            _buildUpcomingSessions(),
            const SizedBox(height: 20),

            // Pending Hand Analyses
            _buildPendingAnalyses(),
            const SizedBox(height: 20),

            // Quick Actions
            _buildQuickActions(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingCard() {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryColor, Color(0xFF7B52C1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, Palmist! 🔮',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '3 sessions scheduled today',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: _palmistStatus == 'online'
                            ? AppTheme.onlineColor
                            : _palmistStatus == 'busy'
                                ? AppTheme.busyColor
                                : AppTheme.offlineColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _palmistStatus == 'online'
                            ? 'Accepting clients'
                            : _palmistStatus == 'busy'
                                ? 'In session'
                                : 'Not available',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white24,
            child: Text('🧿', style: TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's Overview", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            _StatCard(
              icon: '📋',
              label: 'Sessions',
              value: '3',
              color: AppTheme.primaryColor,
            ),
            _StatCard(
              icon: '✅',
              label: 'Completed',
              value: '1',
              color: AppTheme.successColor,
            ),
            _StatCard(
              icon: '⏳',
              label: 'Pending',
              value: '2',
              color: AppTheme.warningColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEarningsSummary() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EarningsScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Earnings', style: Theme.of(context).textTheme.titleLarge),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppTheme.textSecondary),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _EarningItem(
                    label: 'Today',
                    amount: '₹ 1,497',
                    icon: '📅',
                  ),
                ),
                Container(width: 1, height: 40, color: AppTheme.dividerColor),
                Expanded(
                  child: _EarningItem(
                    label: 'This Month',
                    amount: '₹ 18,450',
                    icon: '📆',
                  ),
                ),
                Container(width: 1, height: 40, color: AppTheme.dividerColor),
                Expanded(
                  child: _EarningItem(
                    label: 'Total',
                    amount: '₹ 1.2L',
                    icon: '💰',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingSessions() {
    final sessions = [
      {
        'name': 'Rahul Sharma',
        'time': '2:00 PM',
        'type': 'Career Reading',
        'status': 'scheduled',
      },
      {
        'name': 'Priya Patel',
        'time': '4:30 PM',
        'type': 'Love & Relationships',
        'status': 'scheduled',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Upcoming Sessions',
                style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConsultationsScreen()),
              ),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...sessions.map((s) => _SessionCard(session: s)),
      ],
    );
  }

  Widget _buildPendingAnalyses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pending Analyses',
                style: Theme.of(context).textTheme.titleLarge),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '2 pending',
                style: TextStyle(
                    color: AppTheme.warningColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.back_hand_outlined,
                  color: AppTheme.primaryColor),
            ),
            title: const Text('Amit Kumar - Active Hand'),
            subtitle: const Text('Submitted 2 hours ago'),
            trailing: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HandAnalysisScreen()),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Analyze', style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.back_hand_outlined,
                  color: AppTheme.secondaryColor),
            ),
            title: const Text('Sunita Devi - Both Hands'),
            subtitle: const Text('Submitted 5 hours ago'),
            trailing: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HandAnalysisScreen()),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Analyze', style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
          children: [
            _QuickActionCard(
              icon: '🗓️',
              label: 'Schedule',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScheduleScreen()),
              ),
            ),
            _QuickActionCard(
              icon: '🖐️',
              label: 'Analyze Hand',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HandAnalysisScreen()),
              ),
            ),
            _QuickActionCard(
              icon: '💰',
              label: 'Earnings',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EarningsScreen()),
              ),
            ),
            _QuickActionCard(
              icon: '📊',
              label: 'Reports',
              onTap: () {},
            ),
            _QuickActionCard(
              icon: '💊',
              label: 'Remedies',
              onTap: () {},
            ),
            _QuickActionCard(
              icon: '⭐',
              label: 'Reviews',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Helper Widgets ───────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 26)),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarningItem extends StatelessWidget {
  final String label;
  final String amount;
  final String icon;

  const _EarningItem(
      {required this.label, required this.amount, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppTheme.primaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  final Map<String, String> session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          child: Text(
            session['name']![0],
            style: const TextStyle(
                color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(session['name']!,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(session['type']!),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              session['time']!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                  fontSize: 13),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.infoColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Scheduled',
                style: TextStyle(fontSize: 10, color: AppTheme.infoColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
