import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMNotificationServices {
  var localNotificationPlugin = FlutterLocalNotificationsPlugin();

  initNotificationPlugin() {
    localNotificationPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher")));
  }

  showDemoNotification(RemoteMessage message) {
    localNotificationPlugin.show(
        hashCode,
        message.notification?.title??"No title",
        message.notification?.body??"",
        const NotificationDetails(
            android: AndroidNotificationDetails("channelId", "channelName")));
  }

  // firebase messaging
  var fcmInstance = FirebaseMessaging.instance;
  getNotificationToken()async{
    var token = await fcmInstance.getToken();
    print("notification token: $token");
    return token;
  }

  // if application getting up from terminated state

  onTerminatedMessageHandler()async{
    var message = await fcmInstance.getInitialMessage();
    if(message !=null){
      showDemoNotification(message);
    }
  }

  // on foreground notification handler
  onForegroundMessageHandlers()async{
    FirebaseMessaging.onMessage.listen((event) {
      showDemoNotification(event);
    });
  }
}

// on back ground message handler
// @pragma('vm:entry-point')
Future<void> onBackGroundNotificationHandler(RemoteMessage? message)async{
  if(message !=null){
    print("background Message:${message.notification?.title}${message.notification?.body}");
    FCMNotificationServices().showDemoNotification(message);
  }
}
