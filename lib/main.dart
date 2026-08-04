import 'package:flutter/material.dart';

import 'home_page.dart';
import 'loading_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'sample_navigation.dart';
import 'sample_todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Start at loading (splash) → then goes to Login
      home: const LoadingScreen(),

      // All named routes
      routes: {
        LoadingScreen.routeName: (context) => const LoadingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomePage.routeName: (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          return HomePage(
            username: args?['username'] as String? ?? 'User',
            email: args?['email'] as String?,
            token: args?['token'] as String?,
          );
        },
        SampleTodoListScreen.routeName: (context) =>
            const SampleTodoListScreen(),
        SampleNavigationScreen.routeName: (context) =>
            const SampleNavigationScreen(),
        DetailByNamedRouteScreen.routeName: (context) =>
            const DetailByNamedRouteScreen(),
      },
    );
  }
}
