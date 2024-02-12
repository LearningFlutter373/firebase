import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initializeNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var title = message.notification?.title;
      var body = message.notification?.body;
      var an = message.notification?.apple;
      print("Foreground Title: $title");
      print("Foreground Body: $body");
      print("Foreground android: $an");
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    FirebaseMessaging.onMessageOpenedApp;
  }

  Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    var title = message.notification?.title;
    var body = message.notification?.body;
    print("Background Title: $title");
    print("Background Body: $body");

    return Future<void>.value();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    return token;
  }

}
