// Path: lib/features/vehicles/screens/vehicle_details_screen.dart
import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import 'package:smart_auto_hub_app/features/bookings/screens/consultation_booking_screen.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleDetailsScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('\${vehicle.make} \${vehicle.model}')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.directions_car, size: 80, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\${vehicle.year} \${vehicle.make} \${vehicle.model}', 
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$\${vehicle.price}', 
                    style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary)
                  ),
                  const SizedBox(height: 16),
                  Text('Status: \${vehicle.status}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ConsultationBookingScreen(vehicleId: vehicle.id),
                          ),
                        );
                      },
                      child: const Text('Book Consultation'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
