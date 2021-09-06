import 'dart:ui';

import 'package:corona/services/showNotify.dart';
import 'package:corona/ui/screens/ScreenStatus.dart';
import 'package:corona/ui/screens/notifaction.dart';
import 'package:corona/ui/screens/setteings.dart';
import 'package:corona/ui/screens/testCorona.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Profile extends StatefulWidget {
  String type;
  String subType;
  Profile({this.type, this.subType});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool ispostive = false;
  @override
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
            //   height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.type != "infected"
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFA4A8E4),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFA4A8E4),
                                Color(0xFFEEFBFF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/negative.png",
                                ),
                                Text(
                                  "غير مصاب",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16),
                                ),
                                Container(
                                    child: Text(
                                  "اذا كنت مصاب بفيروس كورونا اخبر التطبيق عن طريق تحديث حالتك",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                          ),
                        ))
                    : Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFA4A8E4),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFFF9A26),
                                Color(0xFFEEFBFF),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/postive.png",
                                ),
                                Text(
                                  "مصاب ${widget.subType}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16),
                                ),
                                Container(
                                    child: Text(
                                  "عند انتهاء فترة التعافي 14 يوم سيتم تحديث حالتك تقائياً ",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                          ),
                        )),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Status()));
                          },
                          title: Text("تحديث حالتك"),
                          leading: GFAvatar(
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.2),
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
                              image: AssetImage(
                                  "assets/images/security_warning.png"),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
