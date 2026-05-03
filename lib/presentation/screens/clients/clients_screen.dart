import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../consultations/consultation_detail_screen.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _clients = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'zodiac': 'Leo',
      'totalConsultations': 5,
      'lastConsultation': '2 days ago',
      'rating': 5,
      'isActive': true,
    },
    {
      'id': '2',
      'name': 'Priya Patel',
      'zodiac': 'Virgo',
      'totalConsultations': 3,
      'lastConsultation': '1 week ago',
      'rating': 4,
      'isActive': true,
    },
    {
      'id': '3',
      'name': 'Amit Kumar',
      'zodiac': 'Aries',
      'totalConsultations': 1,
      'lastConsultation': 'Today',
      'rating': 0,
      'isActive': true,
    },
    {
      'id': '4',
      'name': 'Sunita Devi',
      'zodiac': 'Cancer',
      'totalConsultations': 8,
      'lastConsultation': 'Yesterday',
      'rating': 5,
      'isActive': false,
    },
    {
      'id': '5',
      'name': 'Vikram Singh',
      'zodiac': 'Scorpio',
      'totalConsultations': 2,
      'lastConsultation': '3 days ago',
      'rating': 4,
      'isActive': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredClients {
    if (_searchQuery.isEmpty) return _clients;
    return _clients
        .where((c) => (c['name'] as String)
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Clients'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search clients...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _MiniStat(
                    label: 'Total',
                    value: '${_clients.length}',
                    color: AppTheme.primaryColor),
                const SizedBox(width: 12),
                _MiniStat(
                    label: 'Active',
                    value:
                        '${_clients.where((c) => c['isActive'] as bool).length}',
                    color: AppTheme.successColor),
                const SizedBox(width: 12),
                _MiniStat(
                    label: 'This Month', value: '3', color: AppTheme.infoColor),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Client List
          Expanded(
            child: _filteredClients.isEmpty
                ? const Center(
                    child: Text('No clients found',
                        style: TextStyle(color: AppTheme.textSecondary)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredClients.length,
                    itemBuilder: (context, index) {
                      return _ClientCard(
                        client: _filteredClients[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConsultationDetailScreen(
                              session: {
                                'id': _filteredClients[index]['id'],
                                'clientName': _filteredClients[index]['name'],
                                'type': 'General Reading',
                                'time': _filteredClients[index]
                                    ['lastConsultation'],
                                'duration': '30 min',
                                'price': 499.0,
                                'status': 'completed',
                                'isPaid': true,
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: color)),
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  final Map<String, dynamic> client;
  final VoidCallback onTap;

  const _ClientCard({required this.client, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final rating = client['rating'] as int;
    final isActive = client['isActive'] as bool;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Text(
                      (client['name'] as String)[0],
                      style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.onlineColor
                            : AppTheme.offlineColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client['name'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${client['zodiac']} • ${client['totalConsultations']} sessions',
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    if (rating > 0)
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < rating ? Icons.star : Icons.star_border,
                            size: 12,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppTheme.textSecondary),
                  const SizedBox(height: 4),
                  Text(
                    client['lastConsultation'] as String,
                    style: const TextStyle(
                        fontSize: 10, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
