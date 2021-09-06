import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:corona/services/api.dart';
import 'package:corona/services/showNotify.dart';
import 'package:corona/ui/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  String dropdownValue;
  String dropdownValue1;
  @override
  void initState() {
    Show.show.initPusher();
    super.initState();
    print(dropdownValue);
  }

  poststatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    try {
      var data = {"status": dropdownValue};
      var baseurl = Api.api.baseUrl;
      var url = "$baseurl/change/status";
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
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "تحديث حالتك",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  "اخبر التطبيق عن حالتك لتساعد على حماية من حولك",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: DropdownButtonHideUnderline(
                  child: GFDropdown(
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(5),
                    border: const BorderSide(color: Colors.black12, width: 1),
                    dropdownButtonColor: Colors.white,
                    value: dropdownValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        print(dropdownValue);
                        if (dropdownValue != null) {
                          poststatus();
                        }
                      });
                    },
                    items: ['infected', 'not_infected ']
                        .map((value) => DropdownMenuItem(
                              onTap: () async {
                                if (dropdownValue == 'not_infected') {
                                  return ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.white,
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/Scusses.png"),
                                                Text(
                                                  "تم تحديث حالتك",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )));
                                }
                              },
                              value: value,
                              child: Text(
                                  value == 'infected' ? "مصاب" : "غير مصاب"),
                            ))
                        .toList(),
                  ),
                ),
              ),
              dropdownValue == 'infected'
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          "سيتم تغير حالتك  تلفائياً بعد 14 يوم من التعافي و يسيتم  ارسالتحديث حالتك للأجهزة المخالطة لك"),
                    )
                  : Container(),
              dropdownValue == 'infected'
                  ? Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(20),
                      child: DropdownButtonHideUnderline(
                        child: GFDropdown(
                          padding: const EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(5),
                          border:
                              const BorderSide(color: Colors.black12, width: 1),
                          dropdownButtonColor: Colors.white,
                          value: dropdownValue1,
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue1 = newValue;
                              print(dropdownValue1);
                            });
                          },
                          items: ['عادية', 'متحورة']
                              .map((value) => DropdownMenuItem(
                                    onTap: () async {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.white,
                                              content: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    7,
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/Scusses.png"),
                                                    Text(
                                                      "تم تحديث حالتك",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              )));
                                    },
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      if (dropdownValue != null) {
                        Get.to(Profile(
                          type: dropdownValue,
                          subType: dropdownValue1,
                        ));
                      }
                    },
                    child: Text("تأكيد الحالة"),
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
