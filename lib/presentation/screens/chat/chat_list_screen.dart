import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  final List<Map<String, dynamic>> _chats = const [
    {
      'id': '1',
      'clientName': 'Rahul Sharma',
      'lastMessage': 'Thank you for the reading!',
      'time': '2:30 PM',
      'unread': 2,
      'isOnline': true,
    },
    {
      'id': '2',
      'clientName': 'Priya Patel',
      'lastMessage': 'When should I start wearing the gemstone?',
      'time': '11:45 AM',
      'unread': 1,
      'isOnline': false,
    },
    {
      'id': '3',
      'clientName': 'Amit Kumar',
      'lastMessage': 'I have uploaded my hand photos',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': true,
    },
    {
      'id': '4',
      'clientName': 'Sunita Devi',
      'lastMessage': 'The remedy is working well 🙏',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return _ChatTile(
            chat: chat,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  consultationId: chat['id'] as String,
                  clientName: chat['clientName'] as String,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final Map<String, dynamic> chat;
  final VoidCallback onTap;

  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final unread = chat['unread'] as int;
    final isOnline = chat['isOnline'] as bool;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: Text(
              (chat['clientName'] as String)[0],
              style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.onlineColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        chat['clientName'] as String,
        style: TextStyle(
          fontWeight: unread > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        chat['lastMessage'] as String,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: unread > 0 ? AppTheme.textPrimary : AppTheme.textSecondary,
          fontWeight: unread > 0 ? FontWeight.w500 : FontWeight.normal,
          fontSize: 13,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat['time'] as String,
            style: TextStyle(
              fontSize: 11,
              color:
                  unread > 0 ? AppTheme.primaryColor : AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          if (unread > 0)
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$unread',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
