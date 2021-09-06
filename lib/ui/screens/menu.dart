import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:corona/services/api.dart';
import 'package:corona/services/showNotify.dart';
import 'package:corona/ui/screens/ScreenStatus.dart';
import 'package:corona/ui/screens/notifaction.dart';
import 'package:corona/ui/screens/setteings.dart';
import 'package:corona/ui/screens/testCorona.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  setState(VoidCallback fn) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      // print("object");
    });
    super.setState(fn);
  }

  var postion;
  var locationMassge;
  var latitude;
  var longitude;
  postPostion() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    try {
      var data = {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      };
      var baseurl = Api.api.baseUrl;
      var url = "$baseurl/save/location";
      var response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          'Connection': 'keep-alive',
          "Value": "application/json",
          "Authorization": "Bearer ${token}",
        },
        body: data,
      );
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      if (response.statusCode == 200) {
        Get.snackbar("تم  ", "نم إرسال موقعك الحالي");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getCurrentPostion() async {
    postion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPostion = await Geolocator.getLastKnownPosition();
    print(lastPostion);
    latitude = lastPostion.latitude;
    longitude = lastPostion.longitude;
    postPostion();
    setState(() {});
  }

  void initState() {
    Show.show.initPusher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Center(
                    child: Text(
                  "   تحتاج تشغيل الموقع لمعرفه من حولك   ",
                  style: TextStyle(fontSize: 16),
                )),
                Container(
                  child: Center(
                    child: GFButton(
                      onPressed: () async {
                        getCurrentPostion();
                      },
                      text: "     تشغيل الموقع     ",
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 13,
                ),
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Status()));
                      },
                      title: Text("تحديث حالتك"),
                      leading: GFAvatar(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(.2),
                          child: Icon(
                            Icons.coronavirus,
                            color: Colors.yellow,
                          )),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Get.to(Notifactions());
                      },
                      title: Text("كيف اتعامل مع الإشعارات "),
                      leading: GFAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.2),
                        child: Image(
                          image:
                              AssetImage("assets/images/security_warning.png"),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Get.to(CoroonaTest());
                      },
                      title: Text("طلب فحص فيروس كورونا"),
                      leading: GFAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.2),
                        child: Image(
                          image: AssetImage("assets/images/covid-test.png"),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Get.to(Setteings());
                      },
                      title: Text("الإعدادات"),
                      leading: GFAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.2),
                        child: Icon(Icons.settings,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("مشاركة التطبيق"),
                      leading: GFAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(.2),
                        child: Icon(Icons.share,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
