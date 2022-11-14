import 'package:flutter/material.dart';

class LogoPln extends StatelessWidget {
  const LogoPln({Key? key, this.isColored = false}) : super(key: key);

  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(isColored
            ? 'assets/images/logo_mocoringan.png'
            : 'assets/images/logo_pln.png'),
        const SizedBox(height: 25.54),
      ],
    );
  }
}
