// Path: lib/features/bookings/models/booking_model.dart

class BookingModel {
  final String id;
  final String userId;
  final String vehicleId;
  final String date;
  final String time;
  final String status;

  BookingModel({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      vehicleId: json['vehicleId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'vehicleId': vehicleId,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
