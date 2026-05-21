import 'package:flutter/material.dart';
import 'welcome.dart';
import 'basicinfo.dart';
import 'document.dart';
import 'signin.dart';
import 'homepage.dart';
import 'support.dart';
import 'route_details.dart';
import 'support_help.dart';
import 'deliver.dart';
import 'support_connect.dart';
import 'community.dart';
import 'profile.dart'; // ADDED

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoRahi App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/basicinfo': (context) => const BasicInfoScreen(),
        '/documents': (context) => const DocumentScreen(),
        '/signin': (context) => const SigninScreen(),
        '/homepage': (context) => const HomepageScreen(),
        '/support': (context) => const SupportScreen(),
        '/support-help': (context) => const SupportHelpScreen(),
        '/deliver': (context) => const DeliverScreen(),
        '/support_connect': (context) => const SupportConnectScreen(),
        '/community': (context) => const CommunityScreen(),
        '/profile': (context) => const ProfileScreen(), // ADDED
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/route-details') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => RouteDetailsScreen(
              location: args['location'] ?? '',
              subLocation: args['subLocation'] ?? '',
            ),
          );
        }
        return null;
      },
    );
  }
}