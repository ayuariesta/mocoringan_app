import 'package:flutter/material.dart';
import 'package:mocoringan_app/constants.dart';
import 'package:mocoringan_app/responsive.dart';
import 'package:mocoringan_app/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nohpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Responsive(
                mobile: const MobileSignupScreen(),
                desktop: Row(
                  children: [
                    const Expanded(
                      child: SignUpScreenTopImage(),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 450,
                            child: SignUpForm(),
                          ),
                          SizedBox(height: defaultPadding / 2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
