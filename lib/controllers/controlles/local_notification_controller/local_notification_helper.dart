import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppLocalNotificationService {
  static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static get initNotification{
    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(android: AndroidInitializationSettings("assets/icons/smile",)));

  }
  static void showNotification({required String title, required String message}){
    var details =  const AndroidNotificationDetails("EduGaon", "Amnour",enableVibration: true,priority: Priority.max,importance: Importance.max,);
    flutterLocalNotificationsPlugin.show(0, title, message, NotificationDetails(android: details));
  }
}