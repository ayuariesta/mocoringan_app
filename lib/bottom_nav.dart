import 'package:flutter/material.dart';
import 'screen/dashboard.dart';
import 'package:mocoringan_app/constants.dart';
import 'screen/scanner.dart';
import 'screen/proteksi.dart';
import 'screen/search_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/Login/login_screen.dart';
import 'screen/beban.dart';
import 'screen/Profile/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            Dashboard(),
            ProteksiList(),
            DataBebanList(),
            ScannerQRCode(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryLightColor,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Proteksi",
              icon: Icon(
                Icons.format_align_justify,
              ),
            ),
            BottomNavigationBarItem(
              label: "Data Beban",
              icon: Icon(
                Icons.format_align_center,
              ),
            ),
            BottomNavigationBarItem(
              label: "Scanner",
              icon: Icon(
                Icons.scanner,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
