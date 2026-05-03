import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../analysis/hand_analysis_screen.dart';
import '../chat/chat_screen.dart';
import '../remedies/remedy_assignment_screen.dart';
import '../reports/report_builder_screen.dart';

class ConsultationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> session;

  const ConsultationDetailScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final status = session['status'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(session['clientName'] as String),
        actions: [
          if (status == 'scheduled')
            PopupMenuButton<String>(
              onSelected: (value) {
                // TODO: Handle status change
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                    value: 'start', child: Text('Start Session')),
                const PopupMenuItem(
                    value: 'cancel', child: Text('Cancel Session')),
              ],
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Info Card
            _buildClientInfoCard(context),
            const SizedBox(height: 16),

            // Session Details
            _buildSessionDetails(context),
            const SizedBox(height: 16),

            // Client's Question
            _buildClientQuestion(context),
            const SizedBox(height: 16),

            // Action Buttons
            _buildActionButtons(context),
            const SizedBox(height: 16),

            // Hand Scans
            _buildHandScans(context),
          ],
        ),
      ),
      bottomNavigationBar:
          status == 'scheduled' ? _buildBottomBar(context) : null,
    );
  }

  Widget _buildClientInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              child: Text(
                (session['clientName'] as String)[0],
                style: const TextStyle(
                    fontSize: 24,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session['clientName'] as String,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    session['type'] as String,
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _InfoChip(
                          label: session['duration'] as String,
                          icon: Icons.timer_outlined),
                      const SizedBox(width: 8),
                      _InfoChip(
                          label:
                              '₹ ${(session['price'] as double).toStringAsFixed(0)}',
                          icon: Icons.currency_rupee),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Session Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            _DetailRow(
                icon: Icons.access_time,
                label: 'Scheduled',
                value: session['time'] as String),
            const SizedBox(height: 8),
            _DetailRow(
                icon: Icons.payment,
                label: 'Payment',
                value: (session['isPaid'] as bool) ? 'Paid ✅' : 'Pending ⏳'),
            const SizedBox(height: 8),
            _DetailRow(
                icon: Icons.info_outline,
                label: 'Status',
                value: (session['status'] as String)[0].toUpperCase() +
                    (session['status'] as String).substring(1)),
          ],
        ),
      ),
    );
  }

  Widget _buildClientQuestion(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Client's Question",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
              ),
              child: const Text(
                '"Will I get a promotion this year? I have been working hard for 3 years and want to know what my palm says about my career prospects."',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: AppTheme.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Actions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: 'Chat',
                color: AppTheme.infoColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      consultationId: session['id'] as String,
                      clientName: session['clientName'] as String,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ActionButton(
                icon: Icons.back_hand_outlined,
                label: 'Analyze',
                color: AppTheme.primaryColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HandAnalysisScreen()),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ActionButton(
                icon: Icons.description_outlined,
                label: 'Report',
                color: AppTheme.successColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ReportBuilderScreen()),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ActionButton(
                icon: Icons.healing_outlined,
                label: 'Remedies',
                color: AppTheme.warningColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const RemedyAssignmentScreen()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHandScans(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hand Scans',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _HandScanCard(
                label: 'Active Hand',
                icon: '🖐️',
                status: 'Submitted',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HandAnalysisScreen()),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _HandScanCard(
                label: 'Passive Hand',
                icon: '✋',
                status: 'Submitted',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HandAnalysisScreen()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.errorColor,
                side: const BorderSide(color: AppTheme.errorColor),
              ),
              child: const Text('Cancel Session'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Start Session'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppTheme.primaryColor),
          const SizedBox(width: 4),
          Text(label,
              style:
                  const TextStyle(fontSize: 11, color: AppTheme.primaryColor)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondary),
        const SizedBox(width: 8),
        Text('$label: ',
            style:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    color: color, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _HandScanCard extends StatelessWidget {
  final String label;
  final String icon;
  final String status;
  final VoidCallback onTap;

  const _HandScanCard(
      {required this.label,
      required this.icon,
      required this.status,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(status,
                style: const TextStyle(
                    color: AppTheme.successColor, fontSize: 12)),
            const SizedBox(height: 8),
            const Text('Tap to Analyze',
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
