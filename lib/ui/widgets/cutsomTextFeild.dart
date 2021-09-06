import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatefulWidget {
  String label;
  bool isPassword;

  TextEditingController controller = TextEditingController();
  CustomTextFeild(this.label, this.controller, [this.isPassword = false]);

  @override
  _CustomTextFeildState createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.all(15),
      child: TextFormField(
        validator: (String v) {
          if (v.trim().isEmpty) {
            return "requrid";
          }
          return null;
        },
        obscureText: widget.isPassword ? isObscure : false,
        controller: widget.controller,
        decoration: InputDecoration(
          suffix: Visibility(
            visible: widget.isPassword,
            child: IconButton(
              icon: isObscure
                  ? Icon(
                      Icons.visibility_off,
                    )
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                isObscure = !isObscure;
                setState(() {});
              },
            ),
          ),
          filled: true,
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
