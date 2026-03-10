// Path: lib/features/vehicles/models/vehicle_model.dart

class VehicleModel {
  final String id;
  final String make;
  final String model;
  final int year;
  final double price;
  final String status;
  final String imageUrl;

  VehicleModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'price': price,
      'status': status,
      'imageUrl': imageUrl,
    };
  }
}
