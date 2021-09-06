import 'package:corona/ui/screens/onbording.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
     Future.delayed(const Duration(seconds: 3), () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Onbording()));
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6FDFF),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
