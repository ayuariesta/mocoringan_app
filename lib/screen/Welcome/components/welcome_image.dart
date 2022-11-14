import 'package:flutter/material.dart';

import '../../../constants.dart';

class WelcomeImage extends StatefulWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  State<WelcomeImage> createState() => _WelcomeImageState();
}

class _WelcomeImageState extends State<WelcomeImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 70,
              child: Image.asset(
                'assets/images/logo_mocoringan.png',
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
