import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deep Linking in Flutter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Linkify(
            onOpen: (link) async {
              // Function to handle opening the link
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },

            text: "Click here to deep link into the app: https://www.linkedin.com/in/abhi-singh-7a1a11252",
          ),
          ElevatedButton(
            onPressed: () {

              deepLinking();
            },
            child: Text('Open Deep Link'),
          ),



        ],
      ),
    );
  }

  void deepLinking() async {
    var deepLink = "https://www.linkedin.com/in/abhi-singh-7a1a11252";
    if (await canLaunch(deepLink)) {
      await launch(deepLink);
    } else {
      print('Could not launch $deepLink');
    }
  }
}
