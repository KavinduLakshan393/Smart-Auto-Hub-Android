import '../models/vehicle_model.dart';

class VehicleApiService {

  // Mock data for development
  static final List<VehicleModel> _mockVehicles = [
    VehicleModel(
      id: '1',
      brand: 'Toyota',
      model: 'Premio',
      year: 2018,
      mileage: 45000,
      price: 12500000,
      images: ['https://images.unsplash.com/photo-1550355291-bbee04a92027?q=80&w=800'],
      location: 'Colombo',
      transmission: 'Automatic',
      fuelType: 'Petrol',
      status: 'Available',
      type: 'Sedan',
    ),
    VehicleModel(
      id: '2',
      brand: 'Honda',
      model: 'Vezel',
      year: 2017,
      mileage: 62000,
      price: 9800000,
      images: ['https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?q=80&w=800'],
      location: 'Kandy',
      transmission: 'Automatic',
      fuelType: 'Hybrid',
      status: 'Available',
      type: 'SUV',
    ),
    VehicleModel(
      id: '3',
      brand: 'Mitsubishi',
      model: 'Montero Cross',
      year: 2021,
      mileage: 15000,
      price: 32000000,
      images: ['https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?q=80&w=800'],
      location: 'Gampaha',
      transmission: 'Automatic',
      fuelType: 'Diesel',
      status: 'Shipped',
      type: 'SUV',
    ),
  ];

  Future<List<VehicleModel>> fetchVehicles({Map<String, dynamic>? queryParams}) async {
    // Returning mock data directly for development as requested
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return _mockVehicles;
  }

  Future<VehicleModel> fetchVehicleDetails(String id) async {
    // Returning mock data directly for development as requested
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return _mockVehicles.firstWhere(
      (v) => v.id == id,
      orElse: () => _mockVehicles.first,
    );
  }
}
