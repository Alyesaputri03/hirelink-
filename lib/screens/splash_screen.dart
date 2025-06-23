import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: 'Hire', style: TextStyle(color: Colors.blueAccent)),
                  TextSpan(text: 'Link', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text('Start'),
              ),
            )
          ],
        ),
      ),
    );
  }
}