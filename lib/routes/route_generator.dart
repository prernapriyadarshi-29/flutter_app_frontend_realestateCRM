import 'package:flutter/material.dart';

import '../splash_screen.dart';
import '../welcome_screen.dart';
import '../login_screen.dart';
import '../dashboard_screen.dart';
import '../property_list_screen.dart';
import '../property_add_form_screen.dart';
import '../property_details_list.dart';
import '../lead_screen.dart';
import '../agent_profile_screen.dart';
import '../property_for_list.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
      RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );

      case AppRoutes.propertyList:
        return MaterialPageRoute(
          builder: (_) =>
              const PropertyListScreen(),
        );

      case AppRoutes.addProperty:
        return MaterialPageRoute(
          builder: (_) =>
              const PropertyAddFormScreen(),
        );

      case AppRoutes.leads:
        return MaterialPageRoute(
          builder: (_) => const LeadScreen(),
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) =>
              const AgentProfileScreen(),
        );

      case AppRoutes.propertyDetails:
        final property =
            settings.arguments
                as PropertyForList?;

        if (property == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child:
                    Text('No Property Found'),
              ),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) =>
              PropertyDetailsScreen(
            property: property,
          ),
        );
    
        case AppRoutes.propertyDetails:
  final property =
      settings.arguments as PropertyForList?;

  if (property == null) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('No Property Found'),
        ),
      ),
    );
  }

  return MaterialPageRoute(
    builder: (_) => PropertyDetailsScreen(
      property: property,
    ),
  );

default:
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      body: Center(
        child: Text('Page Not Found'),
      ),
    ),
  );
    }
  }
}