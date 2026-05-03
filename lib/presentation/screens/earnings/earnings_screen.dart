import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _transactions = [
    {
      'clientName': 'Rahul Sharma',
      'type': 'Career Reading',
      'amount': 499.0,
      'netAmount': 399.2,
      'date': 'Today, 2:30 PM',
      'status': 'credited',
    },
    {
      'clientName': 'Priya Patel',
      'type': 'Love & Relationships',
      'amount': 699.0,
      'netAmount': 559.2,
      'date': 'Today, 11:00 AM',
      'status': 'credited',
    },
    {
      'clientName': 'Sunita Devi',
      'type': 'Health & Wellness',
      'amount': 899.0,
      'netAmount': 719.2,
      'date': 'Yesterday',
      'status': 'credited',
    },
    {
      'clientName': 'Vikram Singh',
      'type': 'Business',
      'amount': 499.0,
      'netAmount': 399.2,
      'date': '2 days ago',
      'status': 'credited',
    },
    {
      'clientName': 'Withdrawal',
      'type': 'Bank Transfer',
      'amount': -5000.0,
      'netAmount': -5000.0,
      'date': '3 days ago',
      'status': 'withdrawn',
    },
  ];

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
        title: const Text('Earnings'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppTheme.accentColor,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Transactions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildTransactionsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Total Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryColor, Color(0xFF7B52C1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  '₹ 13,450',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _showWithdrawDialog,
                  icon: const Icon(Icons.account_balance_outlined, size: 18),
                  label: const Text('Withdraw to Bank'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _EarningStatCard(
                label: 'Today',
                amount: '₹ 1,497',
                sessions: '3 sessions',
                color: AppTheme.infoColor,
                icon: '📅',
              ),
              _EarningStatCard(
                label: 'This Week',
                amount: '₹ 5,890',
                sessions: '12 sessions',
                color: AppTheme.successColor,
                icon: '📆',
              ),
              _EarningStatCard(
                label: 'This Month',
                amount: '₹ 18,450',
                sessions: '38 sessions',
                color: AppTheme.warningColor,
                icon: '🗓️',
              ),
              _EarningStatCard(
                label: 'Total Earned',
                amount: '₹ 1.2L',
                sessions: '248 sessions',
                color: AppTheme.primaryColor,
                icon: '💰',
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Rating Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Rating',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < 5 ? Icons.star : Icons.star_border,
                                color: AppTheme.accentColor,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Based on 124 reviews',
                            style: TextStyle(
                                color: AppTheme.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final tx = _transactions[index];
        final isWithdrawal = tx['status'] == 'withdrawn';
        final amount = tx['amount'] as double;

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isWithdrawal
                    ? AppTheme.errorColor.withOpacity(0.1)
                    : AppTheme.successColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isWithdrawal ? Icons.arrow_upward : Icons.arrow_downward,
                color:
                    isWithdrawal ? AppTheme.errorColor : AppTheme.successColor,
              ),
            ),
            title: Text(tx['clientName'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              '${tx['type']} • ${tx['date']}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${amount < 0 ? '-' : '+'}₹ ${amount.abs().toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isWithdrawal
                        ? AppTheme.errorColor
                        : AppTheme.successColor,
                    fontSize: 14,
                  ),
                ),
                if (!isWithdrawal)
                  Text(
                    'Net: ₹ ${(tx['netAmount'] as double).toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 10, color: AppTheme.textSecondary),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Withdraw Earnings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Available: ₹ 13,450'),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount to Withdraw',
                prefixText: '₹ ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Withdrawal request submitted!'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }
}

class _EarningStatCard extends StatelessWidget {
  final String label;
  final String amount;
  final String sessions;
  final Color color;
  final String icon;

  const _EarningStatCard({
    required this.label,
    required this.amount,
    required this.sessions,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(amount,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: color)),
              Text(sessions,
                  style: const TextStyle(
                      fontSize: 10, color: AppTheme.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
