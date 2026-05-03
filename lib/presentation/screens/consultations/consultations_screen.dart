import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'consultation_detail_screen.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _upcomingSessions = [
    {
      'id': '1',
      'clientName': 'Rahul Sharma',
      'type': 'Career Reading',
      'time': 'Today, 2:00 PM',
      'duration': '30 min',
      'price': 499.0,
      'status': 'scheduled',
      'isPaid': true,
    },
    {
      'id': '2',
      'clientName': 'Priya Patel',
      'type': 'Love & Relationships',
      'time': 'Today, 4:30 PM',
      'duration': '45 min',
      'price': 699.0,
      'status': 'scheduled',
      'isPaid': true,
    },
    {
      'id': '3',
      'clientName': 'Amit Kumar',
      'type': 'General Reading',
      'time': 'Tomorrow, 11:00 AM',
      'duration': '30 min',
      'price': 499.0,
      'status': 'scheduled',
      'isPaid': false,
    },
  ];

  final List<Map<String, dynamic>> _completedSessions = [
    {
      'id': '4',
      'clientName': 'Sunita Devi',
      'type': 'Health & Wellness',
      'time': 'Yesterday, 3:00 PM',
      'duration': '60 min',
      'price': 899.0,
      'status': 'completed',
      'isPaid': true,
      'rating': 5,
    },
    {
      'id': '5',
      'clientName': 'Vikram Singh',
      'type': 'Business',
      'time': '2 days ago',
      'duration': '30 min',
      'price': 499.0,
      'status': 'completed',
      'isPaid': true,
      'rating': 4,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Sessions'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppTheme.accentColor,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSessionList(_upcomingSessions, 'upcoming'),
          _buildSessionList(_completedSessions, 'completed'),
          _buildEmptyState('No cancelled sessions'),
        ],
      ),
    );
  }

  Widget _buildSessionList(List<Map<String, dynamic>> sessions, String type) {
    if (sessions.isEmpty) {
      return _buildEmptyState('No $type sessions');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return _ConsultationCard(
          session: session,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConsultationDetailScreen(session: session),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📋', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(message,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
        ],
      ),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final Map<String, dynamic> session;
  final VoidCallback onTap;

  const _ConsultationCard({required this.session, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final status = session['status'] as String;
    final isPaid = session['isPaid'] as bool;

    Color statusColor;
    switch (status) {
      case 'scheduled':
        statusColor = AppTheme.infoColor;
        break;
      case 'ongoing':
        statusColor = AppTheme.warningColor;
        break;
      case 'completed':
        statusColor = AppTheme.successColor;
        break;
      default:
        statusColor = AppTheme.errorColor;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Text(
                      (session['clientName'] as String)[0],
                      style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session['clientName'] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          session['type'] as String,
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status[0].toUpperCase() + status.substring(1),
                      style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 14, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(session['time'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textSecondary)),
                  const SizedBox(width: 16),
                  const Icon(Icons.timer_outlined,
                      size: 14, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(session['duration'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textSecondary)),
                  const Spacer(),
                  Text(
                    '₹ ${(session['price'] as double).toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                        fontSize: 15),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isPaid ? Icons.check_circle : Icons.pending,
                    size: 16,
                    color:
                        isPaid ? AppTheme.successColor : AppTheme.warningColor,
                  ),
                ],
              ),
              if (session.containsKey('rating')) ...[
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < (session['rating'] as int)
                          ? Icons.star
                          : Icons.star_border,
                      size: 14,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
