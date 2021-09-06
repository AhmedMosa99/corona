import 'package:corona/services/api.dart';
import 'package:corona/ui/screens/login.dart';
import 'package:corona/ui/screens/menu.dart';
import 'package:corona/ui/widgets/cutsomTextFeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Reigester extends StatefulWidget {
  @override
  _ReigesterState createState() => _ReigesterState();
}

class _ReigesterState extends State<Reigester> {
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  register() async {
    try {
      var data = {
        "name": name.text,
        "password": password.text,
        "phone": phone.text,
      };
      var baseUrl = Api.api.baseUrl;
      print(baseUrl);
      var url = ("$baseUrl/auth/tokens/new");
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
      if (response.statusCode == 201) {
        savePref(
            responsebody['token'], responsebody['user']['id'], password.text);
        Get.snackbar("", "تم تسجيل حساب");
        print(password);
        print(phone);
        Get.to(Menu());
      } else {
        Get.snackbar("خطأ", "رقم موجود مسبقا");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  savePref(String token, int id, String password) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setInt("id", id);
    preferences.setString("password", password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: formKeys,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "تسجيل حساب جديد",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  CustomTextFeild(
                    "الإسم رباعي ",
                    name,
                  ),
                  CustomTextFeild(
                    "رقم الهاتف",
                    phone,
                  ),
                  CustomTextFeild("كلمة المرور", password, true),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "تسجيل دخول؟",
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
                        if (formKeys.currentState.validate()) {
                          formKeys.currentState.save();

                          register();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('تاكد من ادخال الصحيح')),
                          );
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
        ),
      ),
    );
  }
}
