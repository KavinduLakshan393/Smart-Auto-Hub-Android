
enum BookingStatus {
  pending,
  confirmed,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  static BookingStatus fromString(String value) {
    return BookingStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => BookingStatus.pending,
    );
  }
}

class BookingModel {
  final String id;
  final String serviceType;
  final String vehicleDetails;
  final DateTime scheduledDate;
  final BookingStatus status;

  BookingModel({
    required this.id,
    required this.serviceType,
    required this.vehicleDetails,
    required this.scheduledDate,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'].toString(),
      serviceType: json['serviceType'] as String,
      vehicleDetails: json['vehicleDetails'] as String,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      status: BookingStatus.fromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceType': serviceType,
      'vehicleDetails': vehicleDetails,
      'scheduledDate': scheduledDate.toIso8601String(),
      'status': status.name,
    };
  }
}
