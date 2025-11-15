import 'colors.dart';

class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.fda.gov/drug';
  static const String apiKey = 'YOUR_API_KEY'; // Optional for FDA API
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String ordersCollection = 'orders';
  static const String cartCollection = 'cart';
  static const String favoritesCollection = 'favorites';
  
  // Asset Paths
  static const String logoPath = 'assets/logo/medlink_logo.png';
  static const String pharmacyPlaceholder = 'assets/images/pharmacy_placeholder.jpg';
  static const String userPlaceholder = 'assets/images/user_placeholder.png';
  static const String panadolImage = 'assets/images/panadol.png';
  
  // Icon Paths
  static const String heartIcon = 'assets/icons/heart_icon.png';
  static const String pillIcon = 'assets/icons/pill_icon.png';
  static const String mentalHealthIcon = 'assets/icons/mental_health_icon.png';
  static const String vitaminsIcon = 'assets/icons/vitamins_icon.png';
  static const String babyCareIcon = 'assets/icons/baby_care_icon.png';
  static const String skinCareIcon = 'assets/icons/skin_care_icon.png';
  static const String eyeEarIcon = 'assets/icons/eye_ear_icon.png';
  static const String firstAidIcon = 'assets/icons/first_aid_icon.png';
  
  // Categories
  static const List<Map<String, dynamic>> categories = [
    {
      'id': 'heart_medications',
      'name': 'Heart\nMedications',
      'icon': heartIcon,
      'color': AppColors.categoryPink,
    },
    {
      'id': 'cold_flu',
      'name': 'Cold & Flu',
      'icon': pillIcon,
      'color': AppColors.categoryLightBlue,
    },
    {
      'id': 'mental_health',
      'name': 'Mental\nHealth',
      'icon': mentalHealthIcon,
      'color': AppColors.categoryPurple,
    },
    {
      'id': 'pain_relief',
      'name': 'Pain Relief',
      'icon': pillIcon,
      'color': AppColors.categoryPink,
    },
    {
      'id': 'baby_care',
      'name': 'Baby Care',
      'icon': babyCareIcon,
      'color': AppColors.categoryYellow,
    },
    {
      'id': 'vitamins',
      'name': 'Vitamins &\nSupplements',
      'icon': vitaminsIcon,
      'color': AppColors.categoryMintGreen,
    },
    {
      'id': 'skin_care',
      'name': 'Skin Care',
      'icon': skinCareIcon,
      'color': AppColors.categoryLavender,
    },
    {
      'id': 'eye_ear',
      'name': 'Eye & Ear\nCare',
      'icon': eyeEarIcon,
      'color': AppColors.categoryLightGray,
    },
    {
      'id': 'first_aid',
      'name': 'First Aid',
      'icon': firstAidIcon,
      'color': AppColors.categoryPinkRed,
    },
  ];
  
  // Validation
  static const int minPasswordLength = 6;
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}