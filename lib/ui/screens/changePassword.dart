import 'dart:convert';

import 'package:corona/services/showNotify.dart';
import 'package:corona/ui/screens/menu.dart';
import 'package:corona/ui/screens/setteings.dart';
import 'package:corona/ui/widgets/cutsomTextFeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpassword = TextEditingController();

  TextEditingController newpassword = TextEditingController();

  GlobalKey<FormState> changeKey = GlobalKey<FormState>();

  editUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String password = preferences.get("password");
    String token = preferences.get("token");
    print(password);
    var body = {
      "password": newpassword.text,
    };
    if (password == oldpassword.text) {
      try {
        var client = http.Client();
        // var baseUrl = Api.api.baseUrl;
        var url =
            ("https://asmai.online/abed/corona/public/api/auth/user/edit");
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Container(
              height: MediaQuery.of(context).size.height / 7,
              child: Column(
                children: [
                  Image.asset("assets/images/Scusses.png"),
                  Text(
                    "تم تغير كلمة سرك ",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            )));
        Get.off(Setteings());
        setState(() {});
      } on Exception catch (e) {
        print(e);
      }
    } else {
      Get.snackbar("خطا", "كلمة المرور خاطئة");
    }
  }

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
            " الإعدادات",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Form(
          key: changeKey,
          child: Column(
            children: [
              CustomTextFeild('كلمة السر القديمة', oldpassword, true),
              CustomTextFeild('كلمة السر الجديدة', newpassword, true),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                margin: EdgeInsets.all(15),
                width: double.infinity,
                child: FlatButton(
                  child: Text(
                    "تغير ",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    if (changeKey.currentState.validate()) {
                      changeKey.currentState.save();
                      editUser();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Menu()));
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
