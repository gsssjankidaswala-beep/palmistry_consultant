import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final String id;
  final String consultationId;
  final String clientId;
  final String palmistId;
  final String reportTitle;
  final String reportContent;
  final String? reportPdfUrl;
  final List<String> keyFindings;
  final List<String> recommendations;
  final Map<String, String> lineInterpretations; // lifeline, headline, etc.
  final List<Map<String, dynamic>> specialMarks; // moles, stars, crosses
  final DateTime generatedAt;
  final DateTime createdAt;

  const ReportEntity({
    required this.id,
    required this.consultationId,
    required this.clientId,
    required this.palmistId,
    required this.reportTitle,
    required this.reportContent,
    this.reportPdfUrl,
    this.keyFindings = const [],
    this.recommendations = const [],
    this.lineInterpretations = const {},
    this.specialMarks = const [],
    required this.generatedAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        consultationId,
        clientId,
        palmistId,
        reportTitle,
        reportContent,
        reportPdfUrl,
        keyFindings,
        recommendations,
        lineInterpretations,
        specialMarks,
        generatedAt,
        createdAt,
      ];
}
