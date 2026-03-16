import 'package:flutter/material.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Signup/activity_screen.dart';
import 'Screens/Signup/auth_method_screen.dart';
import 'Screens/Signup/birth_screen.dart';
import 'Screens/Signup/current_weight_screen.dart' show CurrentWeightScreen;
import 'Screens/Signup/goal_weight_screen.dart';
import 'Screens/Signup/loading_screen.dart';
import 'Screens/Signup/meal_goal_screen.dart';
import 'Screens/Signup/navigator.dart';
import 'Screens/Signup/obesity_screen.dart';
import 'Screens/Signup/review_screen.dart';
import 'Screens/Signup/success_screen.dart';
import 'Screens/Splash_Screen.dart';
import 'main/home_screen.dart';
import 'utils/page_transitions.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriSeseSmart',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: const Color(0xfff6f3ef),
      ),
      // Open SplashScreen first
      home: SplashScreen(), // changed from LoginScreen to SplashScreen
      onGenerateRoute: (settings) {
        final Widget page = _buildPage(settings.name ?? '');
        if (page != const SizedBox.shrink()) {
          return CustomPageTransitions.slideAndFadeTransition(page);
        }
        return null;
      },
      routes: {
        '/login': (context) => const LoginScreen(),
        '/navigator': (context) => const NavigatorScreen(),
        '/birth': (context) => const BirthScreen(),
        '/current_weight': (context) => const CurrentWeightScreen(),
        '/goal_weight': (context) => const GoalWeightScreen(),
        '/obesity': (context) => const ObesityScreen(),
        '/activity': (context) => const ActivityScreen(),
        '/meal_goal': (context) => const MealGoalScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/review': (context) => const ReviewScreen(),
        '/auth_method': (context) => const AuthMethodScreen(),
        '/success': (context) => const SuccessScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }

  Widget _buildPage(String routeName) {
    switch (routeName) {
      case '/login':
        return const LoginScreen();
      case '/navigator':
        return const NavigatorScreen();
      case '/birth':
        return const BirthScreen();
      case '/current_weight':
        return const CurrentWeightScreen();
      case '/goal_weight':
        return const GoalWeightScreen();
      case '/obesity':
        return const ObesityScreen();
      case '/activity':
        return const ActivityScreen();
      case '/meal_goal':
        return const MealGoalScreen();
      case '/loading':
        return const LoadingScreen();
      case '/review':
        return const ReviewScreen();
      case '/auth_method':
        return const AuthMethodScreen();
      case '/success':
        return const SuccessScreen();
      case '/home':
        return const HomeScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
