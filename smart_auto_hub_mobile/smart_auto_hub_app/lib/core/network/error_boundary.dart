// Path: lib/core/network/error_boundary.dart

class ErrorBoundary {
  Future<T> run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stackTrace) {
      // Log error internally or report to a service like Crashlytics
      print('ErrorBoundary caught error: $e\\n$stackTrace');
      
      // Re-throw custom exception or handle gracefully
      throw Exception('Network request failed: $e');
    }
  }
}
