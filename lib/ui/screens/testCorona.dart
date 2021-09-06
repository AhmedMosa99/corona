import 'package:corona/services/showNotify.dart';
import 'package:corona/ui/widgets/cutsomTextFeild.dart';
import 'package:flutter/material.dart';

class CoroonaTest extends StatefulWidget {
  @override
  _CoroonaTestState createState() => _CoroonaTestState();
}

class _CoroonaTestState extends State<CoroonaTest> {
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController age = TextEditingController();
  GlobalKey<FormState> Key = GlobalKey<FormState>();
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
            "طلب فحص فيروس كورونا",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: Key,
          child: Center(
            child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20.0, top: 5, left: 5),
                    child: Text(
                      "بعد إرسال الطلب سيتم التواصل معك لإرسال الجهات المختصة",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  CustomTextFeild(
                    "الإسم رباعي ",
                    name,
                  ),
                  CustomTextFeild(
                    "العمر",
                    age,
                  ),
                  CustomTextFeild(
                    "رقم الهاتف",
                    phone,
                  ),
                  CustomTextFeild("العنوان", adress),
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
                        if (Key.currentState.validate()) {
                          Key.currentState.save();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.white,
                              content: Container(
                                height: MediaQuery.of(context).size.height / 7,
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/Scusses.png"),
                                    Text(
                                      "تم إرسال  طلبك",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              )));
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
