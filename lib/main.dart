import 'package:flutter/material.dart';

import 'models/tour_package.dart';
import 'routes/app_routes.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/not_found_screen.dart';

void main() {
  runApp(const NusaTravelApp());
}

class NusaTravelApp extends StatelessWidget {
  const NusaTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaTravel',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),

      initialRoute: AppRoutes.splash,

      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.booking: (context) => const BookingScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          final args = settings.arguments;

          if (args is Map<String, dynamic> && args['package'] is TourPackage) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) =>
                  DetailScreen(package: args['package'] as TourPackage),
            );
          }
        }

        return null;
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) =>
              NotFoundScreen(routeName: settings.name ?? 'unknown'),
        );
      },
    );
  }
}
