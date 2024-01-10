import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/auth_screen.dart';

import 'firebase_options.dart';

final colorScheme = ColorScheme.fromSeed(
  // brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 63, 17, 177),
  background: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.primary,
  colorScheme: colorScheme,
);

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterChatApp());
}

class FlutterChatApp extends StatelessWidget {
  const FlutterChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Flutter Chat',
      home: const AuthScreen(),
    );
  }
}
