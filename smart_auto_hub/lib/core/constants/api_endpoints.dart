class ApiEndpoints {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS/Web, or your local machine IP
  static const String baseUrl = 'http://10.0.2.2:3000/api'; 
  
  // Vehicle endpoints
  static const String vehicles = '/vehicles';
  static String vehicleDetails(String id) => '/vehicles/$id';
}
