import 'package:equatable/equatable.dart';

class EarningEntity extends Equatable {
  final String id;
  final String palmistId;
  final String consultationId;
  final String clientId;
  final String clientName;
  final double amount;
  final double platformFee; // percentage cut
  final double netAmount;
  final String paymentMethod;
  final String status; // pending | credited | withdrawn
  final DateTime earnedAt;
  final DateTime? withdrawnAt;

  const EarningEntity({
    required this.id,
    required this.palmistId,
    required this.consultationId,
    required this.clientId,
    required this.clientName,
    required this.amount,
    this.platformFee = 0.2, // 20% platform fee
    required this.netAmount,
    required this.paymentMethod,
    this.status = 'pending',
    required this.earnedAt,
    this.withdrawnAt,
  });

  @override
  List<Object?> get props => [id, palmistId, consultationId, amount, earnedAt];
}
