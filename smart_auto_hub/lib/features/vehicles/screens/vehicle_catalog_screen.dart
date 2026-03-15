import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/vehicle_model.dart';
import '../services/vehicle_api_service.dart';
import '../widgets/vehicle_card.dart';
import 'vehicle_details_screen.dart';

class VehicleCatalogScreen extends StatefulWidget {
  const VehicleCatalogScreen({super.key});

  @override
  State<VehicleCatalogScreen> createState() => _VehicleCatalogScreenState();
}

class _VehicleCatalogScreenState extends State<VehicleCatalogScreen> {
  final VehicleApiService _apiService = VehicleApiService();
  final TextEditingController _searchController = TextEditingController();
  
  List<VehicleModel> _allVehicles = [];
  List<VehicleModel> _filteredVehicles = [];
  bool _isLoading = true;
  String _sortBy = 'Newest';
  
  // Filter states
  String? _selectedType;
  String? _selectedTransmission;
  RangeValues _priceRange = const RangeValues(0, 50000000);
  RangeValues _mileageRange = const RangeValues(0, 200000);

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() => _isLoading = true);
    try {
      // In a real app, we'd pass filters to the API. 
      // For this implementation, we'll fetch all and filter client-side as per rules.
      final vehicles = await _apiService.fetchVehicles();
      setState(() {
        _allVehicles = vehicles;
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredVehicles = _allVehicles.where((v) {
        final matchesSearch = v.brand.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            v.model.toLowerCase().contains(_searchController.text.toLowerCase());
        final matchesType = _selectedType == null || v.type == _selectedType;
        final matchesTransmission = _selectedTransmission == null || v.transmission == _selectedTransmission;
        final matchesPrice = v.price >= _priceRange.start && v.price <= _priceRange.end;
        final matchesMileage = v.mileage >= _mileageRange.start && v.mileage <= _mileageRange.end;

        return matchesSearch && matchesType && matchesTransmission && matchesPrice && matchesMileage;
      }).toList();

      _sortVehicles();
    });
  }

  void _sortVehicles() {
    switch (_sortBy) {
      case 'Price: Low to High':
        _filteredVehicles.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        _filteredVehicles.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Mileage':
        _filteredVehicles.sort((a, b) => a.mileage.compareTo(b.mileage));
        break;
      case 'Newest':
      default:
        _filteredVehicles.sort((a, b) => b.year.compareTo(a.year));
        break;
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 20, right: 20, top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filters', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              _buildFilterSectionTitle('Vehicle Type'),
              Wrap(
                spacing: 8,
                children: ['Sedan', 'SUV', 'Hatchback', 'Van', 'Hybrid'].map((type) {
                  final isSelected = _selectedType == type;
                  return FilterChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (val) => setSheetState(() => _selectedType = val ? type : null),
                    selectedColor: AppColors.primaryRed.withValues(alpha: 0.2),
                    checkmarkColor: AppColors.primaryRed,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildFilterSectionTitle('Transmission'),
              Wrap(
                spacing: 8,
                children: ['Automatic', 'Manual'].map((trans) {
                  final isSelected = _selectedTransmission == trans;
                  return FilterChip(
                    label: Text(trans),
                    selected: isSelected,
                    onSelected: (val) => setSheetState(() => _selectedTransmission = val ? trans : null),
                    selectedColor: AppColors.primaryRed.withValues(alpha: 0.2),
                    checkmarkColor: AppColors.primaryRed,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildFilterSectionTitle('Price Range (LKR)'),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 50000000,
                divisions: 50,
                activeColor: AppColors.primaryRed,
                labels: RangeLabels(_priceRange.start.round().toString(), _priceRange.end.round().toString()),
                onChanged: (val) => setSheetState(() => _priceRange = val),
              ),
              const SizedBox(height: 16),
              _buildFilterSectionTitle('Mileage Range (km)'),
              RangeSlider(
                values: _mileageRange,
                min: 0,
                max: 200000,
                divisions: 40,
                activeColor: AppColors.primaryRed,
                labels: RangeLabels(_mileageRange.start.round().toString(), _mileageRange.end.round().toString()),
                onChanged: (val) => setSheetState(() => _mileageRange = val),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setSheetState(() {
                          _selectedType = null;
                          _selectedTransmission = null;
                          _priceRange = const RangeValues(0, 50000000);
                          _mileageRange = const RangeValues(0, 200000);
                        });
                        _applyFilters();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryRed,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _applyFilters();
                        Navigator.pop(context);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your Perfect Car'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Sticky search and sort
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search brand or model...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onChanged: (v) => _applyFilters(),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _sortBy,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.sort),
                  items: ['Newest', 'Price: Low to High', 'Price: High to Low', 'Mileage']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12))))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _sortBy = val;
                        _sortVehicles();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadVehicles,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredVehicles.isEmpty
                      ? const Center(child: Text('No vehicles found'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                            childAspectRatio: 0.9,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemCount: _filteredVehicles.length,
                          itemBuilder: (context, index) {
                            return VehicleCard(
                              vehicle: _filteredVehicles[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VehicleDetailsScreen(vehicle: _filteredVehicles[index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
