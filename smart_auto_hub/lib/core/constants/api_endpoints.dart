class ApiEndpoints {
  static const String baseUrl = 'https://api.smartautohub.com/v1';
  
  // Vehicle endpoints
  static const String vehicles = '/vehicles';
  static String vehicleDetails(String id) => '/vehicles/$id';
}
