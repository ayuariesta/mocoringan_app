import 'package:flutter/material.dart';
import 'screen/dashboard.dart';
import 'package:mocoringan_app/constants.dart';
import 'screen/scanner.dart';
import 'screen/proteksi.dart';
import 'screen/search_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/Login/login_screen.dart';
import 'screen/beban.dart';

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
      length: 4,
      initialIndex: selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            Dashboard(),
            SearchData(),
            ProteksiList(),
            DataBebanList(),
            ScannerQRCode()
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
              label: "Cari Data",
              icon: Icon(
                Icons.search,
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
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear(); // <- remove sharedpreferences

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                new LoginScreen())); // <- navigasi ke halaman awal
  }
}
