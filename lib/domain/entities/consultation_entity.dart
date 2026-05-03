import 'package:equatable/equatable.dart';

enum ConsultationStatus { scheduled, ongoing, completed, cancelled }

class ConsultationEntity extends Equatable {
  final String id;
  final String clientId;
  final String clientName;
  final String? clientProfileImageUrl;
  final String palmistId;
  final String title;
  final String? description;
  final DateTime scheduledTime;
  final DateTime? completedTime;
  final int durationMinutes;
  final double price;
  final ConsultationStatus status;
  final bool isPaid;
  final String? reportUrl;
  final String? chatRoomId;
  final Map<String, String>? questionnaire;
  final DateTime createdAt;
  final String? cancellationReason;

  const ConsultationEntity({
    required this.id,
    required this.clientId,
    required this.clientName,
    this.clientProfileImageUrl,
    required this.palmistId,
    required this.title,
    this.description,
    required this.scheduledTime,
    this.completedTime,
    required this.durationMinutes,
    required this.price,
    required this.status,
    required this.isPaid,
    this.reportUrl,
    this.chatRoomId,
    this.questionnaire,
    required this.createdAt,
    this.cancellationReason,
  });

  @override
  List<Object?> get props => [
        id,
        clientId,
        clientName,
        palmistId,
        title,
        description,
        scheduledTime,
        completedTime,
        durationMinutes,
        price,
        status,
        isPaid,
        reportUrl,
        chatRoomId,
        createdAt,
      ];
}
