import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Auto Hub'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Sameera Auto Traders!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Action Button'),
            ),
            const SizedBox(height: 16),
            Card(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Themed Card with rounded borders'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
