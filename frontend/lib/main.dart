import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shashlyk_mashlyk_app/screens/home_screen.dart';
import 'package:shashlyk_mashlyk_app/services/cart_service.dart';

void main() {
  runApp(const MyApp());
}

// Define the color palette from the design concept
class AppColors {
  static const Color primary = Color(0xFFD32F2F); // Warm red
  static const Color secondary = Color(0xFFFF8F00); // Golden-orange
  static const Color accent = Color(0xFF388E3C);   // Green
  static const Color textDark = Color(0xFF424242); // Dark grey
  static const Color textLight = Color(0xFFFAFAFA); // Creamy-white
  static const Color background = Color(0xFFFAFAFA); // Creamy-white
  static const Color surface = Colors.white;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartService(),
      child: MaterialApp(
        title: 'Шашлык-Машлык',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            tertiary: AppColors.accent,
            background: AppColors.background,
            surface: AppColors.surface,
            onPrimary: AppColors.textLight,
            onSecondary: Colors.black,
            onSurface: AppColors.textDark,
            onError: Colors.white,
          ),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.textDark),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Roboto', color: AppColors.textDark),
            labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textLight,
            elevation: 0,
            centerTitle: true,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
