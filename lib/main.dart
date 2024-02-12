
import 'package:firebase/controllers/controlles/cloud_firebase_with_provider_controller/cfdb_helper_with_provider.dart';
import 'package:firebase/view/screens/cloud_database_screens/add_data_screen.dart';
import 'package:firebase/view/screens/cloud_database_screens/home_page.dart';
import 'package:firebase/view/screens/cloud_firebase_screens_with_provider/add_data_with_provider_screen.dart';
import 'package:firebase/view/screens/cloud_firebase_screens_with_provider/home_page.dart';
import 'package:firebase/view/screens/deep_linking/deep_linking.dart';
import 'package:firebase/view/screens/deep_linking/share_optione.dart';
import 'package:firebase/view/screens/google_map_screens/singlemarker_googlemap.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'controllers/controlles/fcm_notification_controller/fcm_notification_helper.dart';
import 'controllers/controlles/fcm_notification_controller/fcm_push_not.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FCMNotificationServices().initNotificationPlugin();
  // //FirebaseMessaging.onBackgroundMessage(onBackGroundNotificationHandler);
  // FCMNotificationServices().onForegroundMessageHandlers();
  // FCMNotificationServices().getNotificationToken();
  // FCMNotificationServices().onTerminatedMessageHandler();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    home: ViewDataWithProvider(),
      //home: AddDataCFScreen(updateStatus: false,)
      //home:MyGoogleMap()
     // home:ShareOption()
    );
  }
}


