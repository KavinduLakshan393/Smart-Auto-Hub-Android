
class VehicleModel {
  final String id;
  final String brand;
  final String model;
  final int year;
  final int mileage;
  final double price;
  final List<String> images;
  final String? location;
  final String? transmission;
  final String? fuelType;
  final String? status;
  final String? type;

  VehicleModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.mileage,
    required this.price,
    required this.images,
    this.location,
    this.transmission,
    this.fuelType,
    this.status,
    this.type,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'].toString(),
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      mileage: json['mileage'] as int,
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      location: json['location'] as String?,
      transmission: json['transmission'] as String?,
      fuelType: json['fuelType'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'mileage': mileage,
      'price': price,
      'images': images,
      'location': location,
      'transmission': transmission,
      'fuelType': fuelType,
      'status': status,
      'type': type,
    };
  }
}
