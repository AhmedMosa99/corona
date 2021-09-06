import 'package:corona/services/showNotify.dart';
import 'package:flutter/material.dart';

class Notifactions extends StatefulWidget {
  @override
  _NotifactionsState createState() => _NotifactionsState();
}

class _NotifactionsState extends State<Notifactions> {
  @override
  void initState() {
    Show.show.initPusher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "كيف اتعامل مع الإشعارات",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            Image.asset(
              'assets/images/notifaction.png',
              height: 300,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "متى يرسل التطبيق إشعاراً",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Cairo'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "التطبيق يرسل إشعاراً بعد مخالطتك مدة 15دقيقة على الأقل لشخص مصاب بفيروس كورونا بشرط استخدامه التطبيق",
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey, fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "ماذا افعل بعد تلقي الإشعار",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Cairo'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "من المحتمل ان تكون قد أصبت بفيروس كورونا بسبب مخالطتك لشخص مصاب لذلك يجب عليك البقاء في المنزل حتى تتاكد من عدم اصابتك بالفيروس حتى تمنع من إصابة الاخرين",
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey, fontFamily: 'Cairo'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
