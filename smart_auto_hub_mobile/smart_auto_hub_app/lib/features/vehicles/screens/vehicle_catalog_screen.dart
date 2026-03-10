// Path: lib/features/vehicles/screens/vehicle_catalog_screen.dart
import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import '../services/vehicle_api_service.dart';
import '../widgets/vehicle_card.dart';

class VehicleCatalogScreen extends StatefulWidget {
  const VehicleCatalogScreen({super.key});

  @override
  State<VehicleCatalogScreen> createState() => _VehicleCatalogScreenState();
}

class _VehicleCatalogScreenState extends State<VehicleCatalogScreen> {
  final VehicleApiService _vehicleService = VehicleApiService();
  List<VehicleModel> _vehicles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    try {
      final vehicles = await _vehicleService.getVehicles();
      if (mounted) {
        setState(() {
          _vehicles = vehicles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Catalog')),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error != null 
              ? Center(child: Text('Error: $_error'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _vehicles.length,
                  itemBuilder: (context, index) {
                    return VehicleCard(vehicle: _vehicles[index]);
                  },
                ),
    );
  }
}
