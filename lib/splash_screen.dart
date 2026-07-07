import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();

  Timer(
    const Duration(seconds: 3),
    () {
      if (mounted) {
        Provider.of<AuthService>(
          context,
          listen: false,
        ).completeSplash();
      }
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Professional Deep Blue Background Gradient
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
             Color(0xFF1A237E), // Deep Indigo Blue
             Color(0xFF121212), // Sleek, dark transition
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Spacer to balance the top area
              const SizedBox(height: 40),

              // 2. Main Center Content (Logo & Title)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo container for a subtle professional depth effect
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/company_logo.png',
                      width: 140,
                      height: 140,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Givni Private Limited',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white, // Changed to white for contrast
                    ),
                  ),
                ],
              ),

              // 3. Bottom Content (Loading Indicator & Version)
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cleaner premium indicator custom styled to blue/white
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        backgroundColor: Colors.white24,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[200], // Soft matching accent blue text
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.5,
                        color: Colors.white.withOpacity(0.5), // Subtle branding text
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}