import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocoringan_app/constants.dart';

class SignUpScreenTopImage extends StatefulWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreenTopImage> createState() => _SignUpScreenTopImageState();
}

class _SignUpScreenTopImageState extends State<SignUpScreenTopImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Register".toUpperCase(),
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: SvgPicture.asset("assets/icons/signup1.svg"),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
