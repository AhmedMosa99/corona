import 'dart:convert';
import 'package:corona/ui/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:corona/services/api.dart';
import 'package:corona/services/showNotify.dart';
import 'package:corona/ui/screens/changePassword.dart';
import 'package:corona/ui/widgets/cutsomTextFeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setteings extends StatefulWidget {
  @override
  _SetteingsState createState() => _SetteingsState();
}

class _SetteingsState extends State<Setteings> {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  getUser() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.get("token");
      var client = http.Client();
      var baseUrl = Api.api.baseUrl;
      var url = ("$baseUrl/auth/user/edit");
      var response = await client.post(
        url,
        headers: {
          "Accept": "application/json",
          "Value": "application/json",
          "Authorization": "Bearer ${token}",
        },
      );
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      name.text = responsebody['user']['name'];
      phone.text = responsebody['user']['phone'];
      setState(() {});
    } on Exception catch (e) {
      print(e);
    }
  }

  editUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    var body = {
      "name": name.text,
      "phone": phone.text,
    };
    try {
      var client = http.Client();
      // var baseUrl = Api.api.baseUrl;
      var url = ("https://asmai.online/abed/corona/public/api/auth/user/edit");
      var response = await client.post(
        url,
        headers: {
          "Accept": "application/json",
          "Value": "application/json",
          "Authorization": "Bearer ${token}",
        },
        body: body,
      );
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      name.text = responsebody['user']['name'];
      phone.text = responsebody['user']['phone'];
      setState(() {});
    } on Exception catch (e) {
      print(e);
    }
  }

  logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("token");
  }

  @override
  void initState() {
    Show.show.initPusher();
    getUser();
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
            " الإعدادات",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  editUser();
                },
                child: Text(
                  "حفظ",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                )),
          ],
        ),
        body: Column(
          children: [
            CustomTextFeild(name.text, name),
            CustomTextFeild(phone.text, phone),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Get.to(ChangePassword());
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "تغير كلمة المرور",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                logout();
                Get.snackbar("تسجيل خروج", "تم تسجيل خروج");
                Get.offAll(Login());
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "تسجيل الخروج",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
