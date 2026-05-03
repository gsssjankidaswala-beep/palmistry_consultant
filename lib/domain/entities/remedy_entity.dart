import 'package:equatable/equatable.dart';

enum RemedyType {
  gemstone,
  mantra,
  ritual,
  lifestyle,
  meditation,
  yantra,
  other
}

class RemedyEntity extends Equatable {
  final String id;
  final String consultationId;
  final String clientId;
  final String palmistId;
  final String title;
  final String description;
  final RemedyType type;
  final DateTime startDate;
  final DateTime? endDate;
  final String frequency; // daily | weekly | monthly | once
  final bool isDone;
  final String? productLink;
  final String? productImageUrl;
  final double? estimatedCost;
  final DateTime createdAt;

  const RemedyEntity({
    required this.id,
    required this.consultationId,
    required this.clientId,
    required this.palmistId,
    required this.title,
    required this.description,
    required this.type,
    required this.startDate,
    this.endDate,
    this.frequency = 'daily',
    this.isDone = false,
    this.productLink,
    this.productImageUrl,
    this.estimatedCost,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        consultationId,
        clientId,
        palmistId,
        title,
        description,
        type,
        startDate,
        endDate,
        frequency,
        isDone,
        createdAt,
      ];
}
