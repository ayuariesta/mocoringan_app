//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mocoringan_app/cek_account.dart';
import 'package:mocoringan_app/constants.dart';
import 'package:mocoringan_app/screen/Login/login_screen.dart';
//import 'package:flutter_auth/helpers.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  /*final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  */
  @override
  Widget build(BuildContext context) {
    return Form(
      //key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Anda belum memasukkan username!';
              }
              return null;
            },
            //controller: usernameController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Nama",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person_outline),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Anda belum memasukkan nama!';
                }
                return null;
              },
              //controller: namaController,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Nomor Telepon",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Anda belum memasukkan nomor telepon!';
              }
              return null;
            },
            //controller: teleponController,
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan password yang valid!';
                }
                return null;
              },
              //controller: passwordController,
            ),
          ),
          const SizedBox(height: defaultPadding / 4),
          ElevatedButton(
            onPressed: () {
              //register();
            },
            child: Text("Register".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /*register() async {
    try {
      var dbUser = FirebaseFirestore.instance.collection('users');

      var userCek = await dbUser
          .where('username', isEqualTo: usernameController.text)
          .get()
          .then((value) => value.size > 0 ? true : false);

      if (!userCek) {
        await dbUser.add({
          'username': usernameController.text,
          'nama': namaController.text,
          'password': passwordController.text,
          'telepon': teleponController.text,
        });
        if (mounted) {
          Helpers().showSnackBar(context, 'Registrasi Berhasil', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } else {
        if (mounted) {
          Helpers()
              .showSnackBar(context, 'Registrasi Gagal, Coba Lagi', Colors.red);
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        Helpers().showSnackBar(context, e.message.toString(), Colors.red);
      }
    }
  }*/
}
