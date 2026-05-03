class AppConstants {
  // Firebase Collections (shared with client app)
  static const String usersCollection = 'users';
  static const String consultationsCollection = 'consultations';
  static const String handsCollection = 'hands';
  static const String remediesCollection = 'remedies';
  static const String reportsCollection = 'reports';
  static const String chatsCollection = 'chats';
  static const String schedulesCollection = 'schedules';
  static const String moodsCollection = 'moods';
  static const String notificationsCollection = 'notifications';
  static const String ratingsCollection = 'ratings';
  static const String earningsCollection = 'earnings';

  // User Types
  static const String userTypeClient = 'client';
  static const String userTypePalmist = 'palmist';

  // Consultation Status
  static const String statusScheduled = 'scheduled';
  static const String statusOngoing = 'ongoing';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';

  // Palmist Status
  static const String palmistOnline = 'online';
  static const String palmistBusy = 'busy';
  static const String palmistOffline = 'offline';

  // Analysis Status
  static const String analysisPending = 'pending';
  static const String analysisInProgress = 'in_progress';
  static const String analysisCompleted = 'analyzed';
  static const String analysisArchived = 'archived';

  // Zodiac Signs
  static const List<String> zodiacSigns = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces',
  ];

  // Palm Lines
  static const List<String> palmLines = [
    'Life Line',
    'Head Line',
    'Heart Line',
    'Fate Line',
    'Sun Line',
    'Mercury Line',
    'Marriage Line',
  ];

  // Remedy Types
  static const List<String> remedyTypes = [
    'gemstone',
    'mantra',
    'ritual',
    'lifestyle',
    'meditation',
    'yantra',
    'other',
  ];

  // Specializations
  static const List<String> specializations = [
    'Career & Finance',
    'Love & Relationships',
    'Health & Wellness',
    'Family & Children',
    'Education',
    'Travel',
    'Spiritual Growth',
    'Business',
    'Marriage',
    'General Reading',
  ];

  // Consultation Durations (minutes)
  static const List<int> consultationDurations = [15, 30, 45, 60, 90];

  // Default Prices (INR)
  static const double defaultPrice15Min = 299.0;
  static const double defaultPrice30Min = 499.0;
  static const double defaultPrice60Min = 899.0;

  // UI Constants
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 20.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Error Messages
  static const String networkErrorMessage =
      'Network Error. Please check your connection.';
  static const String serverErrorMessage =
      'Server Error. Please try again later.';
  static const String authErrorMessage =
      'Authentication failed. Please login again.';
}
