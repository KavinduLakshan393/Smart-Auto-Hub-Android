import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Discover Premium Vehicles',
      'subtext':
          'Browse our extensive, filterable catalog to find the exact car that fits your lifestyle.',
      'icon': Icons.directions_car_rounded,
    },
    {
      'title': 'Book Consultations Easily',
      'subtext':
          'Schedule meetings with our expert advisors using our interactive booking system.',
      'icon': Icons.handshake_rounded,
    },
    {
      'title': 'Meet Your AI Co-Pilot',
      'subtext':
          'Have questions? Chat directly with our advanced AI assistant for instant answers about any vehicle.',
      'icon': Icons.smart_toy_rounded,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() {
    // TODO: Route to actual Login Screen and save isFirstLaunch flag locally
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Login / Register Flow'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Area (The Escape Hatch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: Text(
                      'Skip',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Middle Area (The Carousel)
            Expanded(
              flex: 7,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          slide['icon'] as IconData,
                          size: 120,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 48),
                        Text(
                          slide['title'] as String,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['subtext'] as String,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 3. Bottom Area (The Controls)
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 48.0),
              child: Column(
                children: [
                  // Progress Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentIndex == index ? 24.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? colorScheme.primary
                              : colorScheme.onSurface.withOpacity(0.2), // Muted gray
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // The Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex == _slides.length - 1) {
                          _finishOnboarding();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentIndex == _slides.length - 1
                            ? colorScheme.primary
                            : colorScheme.surface,
                        foregroundColor: _currentIndex == _slides.length - 1
                            ? colorScheme.onPrimary
                            : colorScheme.primary,
                        elevation: _currentIndex == _slides.length - 1 ? 2 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: _currentIndex == _slides.length - 1
                              ? BorderSide.none
                              : BorderSide(
                                  color: colorScheme.primary.withOpacity(0.5),
                                ),
                        ),
                      ),
                      child: Text(
                        _currentIndex == _slides.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
