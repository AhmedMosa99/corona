import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:corona/services/api.dart';
import 'package:corona/ui/screens/menu.dart';
import 'package:corona/ui/screens/register.dart';
import 'package:corona/ui/widgets/cutsomTextFeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  savePref(String token, int id, String password) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setInt("id", id);
    preferences.setString("password", password);
  }

  login() async {
    try {
      var data = {
        "password": password.text,
        "phone": phone.text,
      };
      var baseUrl = Api.api.baseUrl;
      print(baseUrl);
      var url = ("$baseUrl/auth/tokens");
      var response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          'Connection': 'keep-alive',
          "Value": "application/json"
        },
        body: data,
      );
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      if (response.statusCode == 200) {
        savePref(
            responsebody['token'], responsebody['user']['id'], password.text);
        print(responsebody['user']['name']);
        Get.snackbar("", "تم تسجيل الدخول,", duration: Duration(seconds: 5));
        Get.to(Menu());
      } else {
        Get.snackbar("خطأ", "كلمة السر خاطئة  ");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: formKey,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "تسجيل الدخول",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  CustomTextFeild(
                    "رقم الهاتف",
                    phone,
                  ),
                  CustomTextFeild("كلمة المرور", password, true),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reigester()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "تسجيل حساب جديد؟",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.all(15),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        "تسجيل ",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          login();
                        } else {}
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
        ),
      ),
    );
  }
}
