import 'package:flutter/material.dart';
import 'profile_menu.dart';
import 'package:mocoringan_app/constants.dart';
import 'profile_logout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocoringan_app/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocoringan_app/screen/Login/login_screen.dart';
import 'update_profile.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var idUser = "";

  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();

  @override
  void initState() {
    userCek();
    fetchProfil();
    super.initState();
  }

  userCek() async {
    final prefs = await SharedPreferences.getInstance();

    var id = prefs.getString('id');

    if (id == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        idUser = id;
      });
    }
  }

  fetchProfil() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var id = prefs.getString('id');

      var dbUser = FirebaseFirestore.instance.collection('users');

      var fetch = await dbUser.doc(id).get().then((value) => value.data());

      if (fetch!.isNotEmpty) {
        setState(() {
          usernameController.text = fetch['username'];
          namaController.text = fetch['nama'];
          passwordController.text = fetch['password'];
          jabatanController.text = fetch['jabatan'];
        });
      } else {
        if (mounted) {
          Helpers().showSnackBar(context, 'Fetch Fail, try again', Colors.red);
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        Helpers().showSnackBar(context, e.message.toString(), Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 40),
          ProfileMenu(
            controller: usernameController,
            icon: "assets/icons/User Icon.svg",
          ),
          ProfileMenu(
            controller: namaController,
            icon: "assets/icons/User Icon.svg",
          ),
          ProfileMenu(
            controller: jabatanController,
            icon: "assets/icons/work.svg",
          ),
          SizedBox(height: 100.0),
          ProfileLogout(
            text: "Update Profile",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new ProfileUpdate()));
            },
          ),
          ProfileLogout(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              final pref = await SharedPreferences.getInstance();
              pref.clear(); // <- remove sharedpreferences

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
