import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:mocoringan_app/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".toUpperCase()),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
