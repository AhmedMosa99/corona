import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Show {
  Show._();

  static Show show = Show._();
  Channel channel;

  initPusher() async {
    try {
      // Pusher.init('0d98221c689adaa70931', PusherOptions(cluster: 'mt1'));
    } on Exception catch (e) {
      print(e);
    }
    // Pusher.connect(onConnectionStateChange: (val) {
    //   print(val.currentState);
    // }, onError: (err) {
    //   print(err);
    // });
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.get("id");
    channel = await Pusher.subscribe("send-notification");
    channel.bind("send-notification", (onEvent) async {
      var data = json.decode(onEvent.data);
      var massage = data['message'];
      //  print(massage);

      List users = data['users'];
      print(users.contains(id));
      print(data['users']);
      if (users.contains(id) == true) {
        Get.snackbar("فحص كرونا", "عليك عزل نفسك لمخالتطك شخص مصاب");
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 8, channelKey: "key2", title: 'فحص كرونا', body: massage),
          schedule: NotificationInterval(
            interval: 2,
            repeats: false,
          ),
        );
      }
    });
  }
}
