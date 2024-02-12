import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  var localNotificationPlugin = FlutterLocalNotificationsPlugin();

  initNotificationPlugin() {
    localNotificationPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher")));
  }

  showDemoNotification(RemoteMessage message) {
    localNotificationPlugin.show(
        hashCode,
        message.notification?.title ?? "",
        message.notification?.body ?? "",
        const NotificationDetails(
            android: AndroidNotificationDetails("channelId", "channelName")));
  }

  // firebase messaging
  var fcmInstance = FirebaseMessaging.instance;

  getNotificationToken() async {
    var token = await fcmInstance.getToken();
    print("notification token: $token");
    return token;
  }

  // if application getting up from terminated state

  onTerminatedMessageHandler() async {
    var message = await fcmInstance.getInitialMessage();
    if (message != null) {
      showDemoNotification(message);
    }
  }

  // on foreground notification handler
  onForegroundMessageHandler() async {
    FirebaseMessaging.onMessage.listen((event) {
      showDemoNotification(event);
    });
  }

  ///send cloud firestore

  Future<void> storeMessage(RemoteMessage message) async {
    try {
      final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
      await messages.add({
        'title': message.notification?.title,
        'body': message.notification?.body,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Message stored successfully!');
    } catch (e) {
      print('Error storing message: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMessageHistory() async {
    final CollectionReference messages =
    FirebaseFirestore.instance.collection('messages');

    QuerySnapshot querySnapshot = await messages.get();

    return querySnapshot.docs.map((DocumentSnapshot doc) {
      return {
        'title': doc['title'],
        'body': doc['body'],
        'timestamp': doc['timestamp'],
      };
    }).toList();
  }


}

// on back ground message handler
// @pragma('vm:entry-point')
Future<void> onBackGroundNotificationHandler(RemoteMessage? message) async {
  if (message != null) {
    print(
        "background Message:${message.notification?.title}${message.notification?.body}");
    NotificationServices().showDemoNotification(message);
  }


}
