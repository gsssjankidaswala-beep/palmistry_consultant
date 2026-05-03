import 'package:equatable/equatable.dart';

enum MessageType { text, voice, image }

class ChatMessageEntity extends Equatable {
  final String id;
  final String consultationId;
  final String senderId;
  final String senderName;
  final String? senderProfileImageUrl;
  final MessageType messageType;
  final String content;
  final String? voiceUrl;
  final int? voiceDuration;
  final String? imageUrl;
  final DateTime timestamp;
  final bool isRead;
  final DateTime? readAt;

  const ChatMessageEntity({
    required this.id,
    required this.consultationId,
    required this.senderId,
    required this.senderName,
    this.senderProfileImageUrl,
    required this.messageType,
    required this.content,
    this.voiceUrl,
    this.voiceDuration,
    this.imageUrl,
    required this.timestamp,
    this.isRead = false,
    this.readAt,
  });

  @override
  List<Object?> get props => [id, consultationId, senderId, content, timestamp];
}
