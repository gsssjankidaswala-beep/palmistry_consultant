import 'package:equatable/equatable.dart';

enum HandType { active, passive }

class HandScanEntity extends Equatable {
  final String id;
  final String userId;
  final String? consultationId;
  final String imageUrl;
  final HandType handType;
  final String? mainQuestion;
  final String? additionalNotes;
  final DateTime capturedAt;
  final String analysisStatus; // pending | in_progress | analyzed | archived
  final Map<String, dynamic>? analysisData;
  final int quality; // 1-10

  const HandScanEntity({
    required this.id,
    required this.userId,
    this.consultationId,
    required this.imageUrl,
    required this.handType,
    this.mainQuestion,
    this.additionalNotes,
    required this.capturedAt,
    this.analysisStatus = 'pending',
    this.analysisData,
    this.quality = 0,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        consultationId,
        imageUrl,
        handType,
        mainQuestion,
        capturedAt,
        analysisStatus,
        analysisData,
        quality,
      ];
}
