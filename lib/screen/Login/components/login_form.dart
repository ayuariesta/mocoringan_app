import 'package:flutter/material.dart';
import 'package:mocoringan_app/cek_account.dart';
import 'package:mocoringan_app/constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var idUser = "";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    userCek();
    super.initState();
  }

  userCek() async {}

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (usern) {},
            decoration: InputDecoration(
              hintText: "Username",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            controller: usernameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              controller: passwordController,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                //login();
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /*login() async {
    try {
      var dbUser = FirebaseFirestore.instance.collection('users');

      var loginCek = await dbUser
          .where('username', isEqualTo: usernameController.text)
          .where('password', isEqualTo: passwordController.text)
          .get()
          .then((value) => value.docs);

      if (loginCek.isNotEmpty) {
        var data = loginCek.first.data();
        print(data);
        saveSharePref(
          loginCek.first.id,
          data['username'],
          data['nama'],
          data['telepon'],
          data['password'],
        );

        if (mounted) {
          Helpers().showSnackBar(context, 'Login Berhasil', Colors.green);
        }

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BasicMainNavigationView()),
            (Route<dynamic> route) => false);
      } else {
        if (mounted) {
          Helpers().showSnackBar(context, 'Login Gagal, Coba Lagi', Colors.red);
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        Helpers().showSnackBar(context, e.message.toString(), Colors.red);
      }
    }
  }

  saveSharePref(id, username, nama, nohp, pw) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('id', id);
    await prefs.setString('username', username);
    await prefs.setString('nama', nama);
    await prefs.setString('telepon', nohp);
    await prefs.setString('password', pw);
  }*/
}
