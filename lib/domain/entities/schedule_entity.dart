import 'package:equatable/equatable.dart';

class ScheduleSlotEntity extends Equatable {
  final String id;
  final String palmistId;
  final int dayOfWeek; // 0=Sunday, 6=Saturday
  final String startTime; // HH:mm
  final String endTime; // HH:mm
  final int slotDurationMinutes;
  final bool isActive;
  final List<Map<String, dynamic>> bookedSlots;
  final List<Map<String, String>> breakTimes;

  const ScheduleSlotEntity({
    required this.id,
    required this.palmistId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.slotDurationMinutes = 30,
    this.isActive = true,
    this.bookedSlots = const [],
    this.breakTimes = const [],
  });

  @override
  List<Object?> get props => [id, palmistId, dayOfWeek, startTime, endTime];
}
