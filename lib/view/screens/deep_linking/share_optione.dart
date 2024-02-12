import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareOption extends StatelessWidget {
  const ShareOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ElevatedButton(onPressed: (){
Share.share("https://console.firebase.google.com/project/fir-4b53d/settings/general/android:com.edugaon.firebase");

          }, child: Text("share"))
        ],
      ),
    );
  }
}
