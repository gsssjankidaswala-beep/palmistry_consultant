import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<String> _days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // Day index -> {isActive, startTime, endTime, slotDuration}
  final Map<int, Map<String, dynamic>> _schedule = {
    1: {
      'isActive': true,
      'startTime': '09:00',
      'endTime': '18:00',
      'slotDuration': 30
    },
    2: {
      'isActive': true,
      'startTime': '09:00',
      'endTime': '18:00',
      'slotDuration': 30
    },
    3: {
      'isActive': true,
      'startTime': '10:00',
      'endTime': '17:00',
      'slotDuration': 45
    },
    4: {
      'isActive': true,
      'startTime': '09:00',
      'endTime': '18:00',
      'slotDuration': 30
    },
    5: {
      'isActive': true,
      'startTime': '09:00',
      'endTime': '16:00',
      'slotDuration': 30
    },
    6: {
      'isActive': false,
      'startTime': '10:00',
      'endTime': '14:00',
      'slotDuration': 30
    },
    0: {
      'isActive': false,
      'startTime': '10:00',
      'endTime': '14:00',
      'slotDuration': 30
    },
  };

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveSchedule,
            child: _isSaving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.infoColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.infoColor.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppTheme.infoColor, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Set your availability. Clients can only book during active hours.',
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Weekly Schedule
            const Text(
              'Weekly Availability',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            ...List.generate(7, (index) {
              final dayIndex = (index + 1) % 7; // Start from Monday
              final dayData = _schedule[dayIndex]!;
              final isActive = dayData['isActive'] as bool;

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _days[dayIndex],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: isActive
                                    ? AppTheme.textPrimary
                                    : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          Switch(
                            value: isActive,
                            activeColor: AppTheme.primaryColor,
                            onChanged: (v) => setState(
                                () => _schedule[dayIndex]!['isActive'] = v),
                          ),
                        ],
                      ),
                      if (isActive) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _TimeSelector(
                                label: 'Start',
                                time: dayData['startTime'] as String,
                                onTap: () =>
                                    _pickTime(context, dayIndex, 'startTime'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('to',
                                  style:
                                      TextStyle(color: AppTheme.textSecondary)),
                            ),
                            Expanded(
                              child: _TimeSelector(
                                label: 'End',
                                time: dayData['endTime'] as String,
                                onTap: () =>
                                    _pickTime(context, dayIndex, 'endTime'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            _SlotDurationSelector(
                              duration: dayData['slotDuration'] as int,
                              onChanged: (v) => setState(() =>
                                  _schedule[dayIndex]!['slotDuration'] = v),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Pricing Section
            const Text(
              'Session Pricing',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _PriceRow(duration: '15 min', price: '₹ 299'),
                    const Divider(),
                    _PriceRow(duration: '30 min', price: '₹ 499'),
                    const Divider(),
                    _PriceRow(duration: '45 min', price: '₹ 699'),
                    const Divider(),
                    _PriceRow(duration: '60 min', price: '₹ 899'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime(
      BuildContext context, int dayIndex, String field) async {
    final current = _schedule[dayIndex]![field] as String;
    final parts = current.split(':');
    final initial =
        TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));

    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked != null) {
      setState(() {
        _schedule[dayIndex]![field] =
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _saveSchedule() {
    setState(() => _isSaving = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schedule saved successfully!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    });
  }
}

class _TimeSelector extends StatelessWidget {
  final String label;
  final String time;
  final VoidCallback onTap;

  const _TimeSelector(
      {required this.label, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: AppTheme.textSecondary)),
            Text(time,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
          ],
        ),
      ),
    );
  }
}

class _SlotDurationSelector extends StatelessWidget {
  final int duration;
  final ValueChanged<int> onChanged;

  const _SlotDurationSelector(
      {required this.duration, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: duration,
      underline: const SizedBox(),
      items: [15, 30, 45, 60]
          .map((d) => DropdownMenuItem(
                value: d,
                child: Text('${d}m', style: const TextStyle(fontSize: 13)),
              ))
          .toList(),
      onChanged: (v) => onChanged(v!),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String duration;
  final String price;

  const _PriceRow({required this.duration, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(duration, style: const TextStyle(color: AppTheme.textSecondary)),
          Text(price,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
        ],
      ),
    );
  }
}
