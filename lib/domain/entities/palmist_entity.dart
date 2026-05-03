import 'package:equatable/equatable.dart';

class PalmistEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? bio;
  final List<String> specializations;
  final int experienceYears;
  final double rating;
  final int totalRatings;
  final int totalConsultations;
  final double totalEarnings;
  final String status; // online | busy | offline
  final bool isVerified;
  final bool isActive;
  final Map<String, dynamic>? availability; // day -> {start, end}
  final double pricePerHour;
  final String? referralCode;
  final DateTime createdAt;
  final DateTime? lastUpdated;

  const PalmistEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    this.specializations = const [],
    this.experienceYears = 0,
    this.rating = 0.0,
    this.totalRatings = 0,
    this.totalConsultations = 0,
    this.totalEarnings = 0.0,
    this.status = 'offline',
    this.isVerified = false,
    this.isActive = true,
    this.availability,
    this.pricePerHour = 499.0,
    this.referralCode,
    required this.createdAt,
    this.lastUpdated,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phoneNumber,
        profileImageUrl,
        bio,
        specializations,
        experienceYears,
        rating,
        totalRatings,
        totalConsultations,
        totalEarnings,
        status,
        isVerified,
        isActive,
        availability,
        pricePerHour,
        referralCode,
        createdAt,
        lastUpdated,
      ];
}
