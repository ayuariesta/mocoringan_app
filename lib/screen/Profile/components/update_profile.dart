import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocoringan_app/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocoringan_app/constants.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  var idUser = "";

  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          fetchProfil();
        },
        child: Center(
          child: ListView(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Text(
                      "Update Profile".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                      controller: usernameController,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.person_outline),
                          ),
                        ),
                        controller: namaController,
                      ),
                    ),
                    TextField(
                      cursorColor: kPrimaryColor,
                      obscureText: _isHidePassword,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglePasswordVisibility();
                          },
                          child: Icon(
                            _isHidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color:
                                _isHidePassword ? kPrimaryColor : kPrimaryColor,
                          ),
                        ),
                      ),
                      controller: passwordController,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.work),
                          ),
                        ),
                        controller: jabatanController,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  updateProfil();
                },
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
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

  updateProfil() async {
    try {
      var dbUser = FirebaseFirestore.instance.collection('users');

      await dbUser.doc(idUser).update({
        'username': usernameController.text,
        'nama': namaController.text,
        'password': passwordController.text,
        'jabatan': jabatanController.text,
      });

      fetchProfil();

      if (mounted) {
        Helpers()
            .showSnackBar(context, 'Update Profile Berhasil', Colors.green);
      }
      Navigator.pop(context, true);
    } on FirebaseException catch (e) {
      if (mounted) {
        Helpers().showSnackBar(context, e.message.toString(), Colors.red);
      }
    }
  }
}
