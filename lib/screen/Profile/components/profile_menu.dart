import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocoringan_app/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    //required this.text,
    required this.icon,
    required this.controller,
    this.press,
  }) : super(key: key);

  final String icon;
  final TextEditingController controller;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        style: TextStyle(
          color: kPrimaryColor,
        ),
        enabled: false,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
          ),
        ),
        controller: controller,
      ),
      /*TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            
            SizedBox(width: 20),
            Expanded(child: Text(text)),
          ],
        ),
      ),*/
    );
  }
}
