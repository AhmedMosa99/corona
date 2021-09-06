import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:corona/ui/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Pusher.init('0d98221c689adaa70931', PusherOptions(cluster: 'mt1'));
  Pusher.connect(onConnectionStateChange: (val) {
    print(val.currentState);
  }, onError: (err) {
    print(err);
  });
  Channel _channel = await Pusher.subscribe("send-notification");
  AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key2',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: Color(0XFF9050DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            enableVibration: true)
      ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff014E7B),
      ),
      home: Splash(),
    );
  }
}
