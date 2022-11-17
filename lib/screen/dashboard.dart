import 'package:flutter/material.dart';
import 'package:mocoringan_app/constants.dart';
import 'search_data.dart';
import 'search_beban.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login/login_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var idUser = "";
  var nama = "";
  var username = "";

  @override
  void initState() {
    userCek();
    super.initState();
  }

  userCek() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString('id');
    String? name = prefs.getString('nama');
    String? usern = prefs.getString('username');

    if (id == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        idUser = id;
        nama = name!;
        username = usern!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Mocoringan App'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Text(
              nama,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 30.0),
            GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(25),
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchData()),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchData()),
                        );
                      },
                      splashColor: kPrimaryColor,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.search,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                            Text("Cari\nData Proteksi",
                                style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchBeban()),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchBeban()),
                        );
                      },
                      splashColor: kPrimaryColor,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.search_outlined,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                            Text("Cari\nData Beban",
                                style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonLogout() {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        child: Text('LOGOUT'),
        onPressed: () async {
          final pref = await SharedPreferences.getInstance();
          pref.clear(); // <- remove sharedpreferences

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new LoginScreen()));
        },
      ),
    );
  }
}
