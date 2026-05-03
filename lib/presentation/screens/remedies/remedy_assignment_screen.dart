import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class RemedyAssignmentScreen extends StatefulWidget {
  const RemedyAssignmentScreen({super.key});

  @override
  State<RemedyAssignmentScreen> createState() => _RemedyAssignmentScreenState();
}

class _RemedyAssignmentScreenState extends State<RemedyAssignmentScreen> {
  final List<Map<String, dynamic>> _assignedRemedies = [
    {
      'title': 'Wear Blue Sapphire',
      'type': 'gemstone',
      'description':
          'Wear a 5-carat blue sapphire on the middle finger of the right hand every Saturday.',
      'frequency': 'daily',
      'startDate': 'May 5, 2026',
    },
    {
      'title': 'Chant Shani Mantra',
      'type': 'mantra',
      'description':
          'Chant "Om Sham Shanicharaya Namah" 108 times every Saturday morning.',
      'frequency': 'weekly',
      'startDate': 'May 5, 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Remedies'),
        actions: [
          TextButton(
            onPressed: _showAddRemedyDialog,
            child: const Text('+ Add',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Client Info Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppTheme.primaryColor.withOpacity(0.08),
            child: const Row(
              children: [
                Icon(Icons.person_outline,
                    color: AppTheme.primaryColor, size: 18),
                SizedBox(width: 8),
                Text(
                  'Assigning remedies for: Rahul Sharma',
                  style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Remedies List
          Expanded(
            child: _assignedRemedies.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _assignedRemedies.length,
                    itemBuilder: (context, index) {
                      return _RemedyCard(
                        remedy: _assignedRemedies[index],
                        onDelete: () =>
                            setState(() => _assignedRemedies.removeAt(index)),
                      );
                    },
                  ),
          ),

          // Send Button
          if (_assignedRemedies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _sendRemedies,
                  icon: const Icon(Icons.send_outlined),
                  label: Text(
                      'Send ${_assignedRemedies.length} Remedies to Client'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('💊', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          const Text('No remedies assigned yet',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _showAddRemedyDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Remedy'),
          ),
        ],
      ),
    );
  }

  void _showAddRemedyDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String selectedType = 'gemstone';
    String selectedFrequency = 'daily';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
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
              const Text('Add New Remedy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Remedy Title *'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: AppConstants.remedyTypes
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t[0].toUpperCase() + t.substring(1)),
                        ))
                    .toList(),
                onChanged: (v) => setModalState(() => selectedType = v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: 'Description / Instructions'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedFrequency,
                decoration: const InputDecoration(labelText: 'Frequency'),
                items: ['daily', 'weekly', 'monthly', 'once']
                    .map((f) => DropdownMenuItem(
                          value: f,
                          child: Text(f[0].toUpperCase() + f.substring(1)),
                        ))
                    .toList(),
                onChanged: (v) => setModalState(() => selectedFrequency = v!),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      setState(() {
                        _assignedRemedies.add({
                          'title': titleController.text,
                          'type': selectedType,
                          'description': descController.text,
                          'frequency': selectedFrequency,
                          'startDate': 'Today',
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Remedy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendRemedies() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_assignedRemedies.length} remedies sent to client!'),
        backgroundColor: AppTheme.successColor,
      ),
    );
    Navigator.pop(context);
  }
}

class _RemedyCard extends StatelessWidget {
  final Map<String, dynamic> remedy;
  final VoidCallback onDelete;

  const _RemedyCard({required this.remedy, required this.onDelete});

  static const Map<String, String> _typeEmojis = {
    'gemstone': '💎',
    'mantra': '🕉️',
    'ritual': '🪔',
    'lifestyle': '🌿',
    'meditation': '🧘',
    'yantra': '🔯',
    'other': '✨',
  };

  @override
  Widget build(BuildContext context) {
    final type = remedy['type'] as String;
    final emoji = _typeEmojis[type] ?? '✨';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        remedy['title'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        '${type[0].toUpperCase()}${type.substring(1)} • ${remedy['frequency']}',
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: AppTheme.errorColor),
                  onPressed: onDelete,
                ),
              ],
            ),
            if ((remedy['description'] as String).isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                remedy['description'] as String,
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 13),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 12, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  'Starts: ${remedy['startDate']}',
                  style: const TextStyle(
                      fontSize: 11, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
