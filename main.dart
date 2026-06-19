import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'task_screen.dart';

// ⚠️ NOTE: If your login/authentication screen is in a separate file, 
// uncomment the line below and change 'login_screen.dart' to your actual file name:
// import 'login_screen.dart'; 

void main() async {
  // Ensures Flutter native bindings are ready before initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initializes Firebase using your auto-generated configurations
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tide Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      
      // The StreamBuilder listens to the user's login state in real-time
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. While checking if the user is logged in, show a loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          
          // 2. If Firebase finds an active logged-in user, send them directly to the Task Screen
          if (snapshot.hasData) {
            return const TaskScreen();
          }
          
          // 3. If no user is logged in, show your authentication screen
          // ⚠️ Change 'PlaceholderLoginScreen()' to the exact class name of the login screen you built!
          return const PlaceholderLoginScreen(); 
        },
      ),
    );
  }
}

// --- TEMPORARY PLACEHOLDER ---
// You can delete this class once you replace 'PlaceholderLoginScreen()' above 
// with your actual auth widget class name.
class PlaceholderLoginScreen extends StatelessWidget {
  const PlaceholderLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Authentication Screen Placeholder',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Replace this with your custom login widget class inside main.dart.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

