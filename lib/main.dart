import 'package:firebase/view/screens/cloud_database_screens/add_data_screen.dart';
import 'package:firebase/view/screens/realtime_database_screens/add_data_screen.dart';
import 'package:firebase/view/screens/realtime_database_screens/read_data_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: AddDataCFScreen(updateStatus: false,)
    );
  }
}


