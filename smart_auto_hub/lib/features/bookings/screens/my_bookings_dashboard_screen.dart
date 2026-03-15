import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../models/booking_model.dart';
import '../services/scheduling_api_service.dart';

class MyBookingsDashboardScreen extends StatefulWidget {
  const MyBookingsDashboardScreen({super.key});

  @override
  State<MyBookingsDashboardScreen> createState() => _MyBookingsDashboardScreenState();
}

class _MyBookingsDashboardScreenState extends State<MyBookingsDashboardScreen> {
  final SchedulingApiService _apiService = SchedulingApiService();
  late Future<List<BookingModel>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    setState(() {
      _bookingsFuture = _apiService.getUserBookings();
    });
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.confirmed:
        return AppColors.info;
      case BookingStatus.pending:
        return AppColors.warning;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _loadBookings,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<BookingModel>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: _loadBookings,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 64,
                    color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No bookings found',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Your scheduled services will appear here'),
                ],
              ),
            );
          }

          final bookings = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.count,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return _BookingCard(
                booking: booking,
                statusColor: _getStatusColor(booking.status),
              );
            },
          );
        },
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingModel booking;
  final Color statusColor;

  const _BookingCard({
    required this.booking,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateStr = DateFormat('MMM dd, yyyy').format(booking.scheduledDate);
    final timeStr = DateFormat('hh:mm a').format(booking.scheduledDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    booking.serviceType,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    booking.status.displayName,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.directions_car, size: 18, color: colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking.vehicleDetails,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_month, size: 18, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '$dateStr at $timeStr',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (booking.status == BookingStatus.pending || 
                    booking.status == BookingStatus.confirmed)
                  TextButton(
                    onPressed: () {
                      // Implement cancellation logic or navigation to details
                    },
                    style: TextButton.styleFrom(foregroundColor: colorScheme.error),
                    child: const Text('Cancel Booking'),
                  ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to booking details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension ListX<T> on List<T> {
  int get count => length;
}
