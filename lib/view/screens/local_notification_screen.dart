import 'package:flutter/material.dart';
import '../../controllers/controlles/local_notification_controller/local_notification_helper.dart';


class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});
  @override
  State<NotificationMain> createState() => _NotificationMainState();
}

class _NotificationMainState extends State<NotificationMain> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Notification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/heart.png'),
          Center(
            child: ElevatedButton(onPressed: (){
              AppLocalNotificationService.showNotification(title: "EduGaon", message: "ajay@gmalcom");
            }, child: Text("send"),style: ElevatedButton.styleFrom(minimumSize: Size(250, 50)),),
          ),
        ],
      ),
    );
  }
}