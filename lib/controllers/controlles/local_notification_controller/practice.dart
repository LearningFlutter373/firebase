// import 'package:firebase/controllers/controlles/local_notification_controller/local_notification_helper.dart';
// import 'package:firebase/view/screens/cloud_database_screens/add_data_screen.dart';
// import 'package:firebase/view/screens/fcm_notification_screen/fcm_notification.dart';
// import 'package:firebase/view/screens/local_notification_screen.dart';
// import 'package:firebase/view/screens/realtime_database_screens/add_data_screen.dart';
// import 'package:firebase/view/screens/realtime_database_screens/read_data_screen.dart';
// import 'package:firebase/view/screens/stepper/steper.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// import 'controllers/controlles/fcm_notification_controller/fcm_helper.dart';
// import 'controllers/controlles/fcm_notification_controller/fcm_notification_helper.dart';
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   AppLocalNotificationService.initNotification;
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await Firebase.initializeApp();
//   AppLocalNotificationService.initNotification();
//   NotificationServices().initNotificationPlugin();
//   FirebaseMessaging.onBackgroundMessage(onBackGroundNotificationHandler);
//   NotificationServices().onForegroundMessageHandler();
//   NotificationServices().getNotificationToken();
//   NotificationServices().onTerminatedMessageHandler();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Firebase',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       //home: AddDataCFScreen(updateStatus: false,)
//       home:Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed: (){},child: Text("click"),
//           ),
//         ),
//         // body: buildMessageList()
//       ),
//     );
//   }
//
//   Widget buildMessageList() {
//     return FutureBuilder(
//       future: NotificationServices().getMessageHistory(),
//       builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final message = snapshot.data![index];
//               return ListTile(
//                 title: Text(message['title']),
//                 subtitle: Text(message['body']),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
//
//
