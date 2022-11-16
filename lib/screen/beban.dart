import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocoringan_app/constants.dart';
import 'input_beban.dart';

class DataBebanList extends StatefulWidget {
  const DataBebanList({super.key});

  @override
  State<DataBebanList> createState() => _DataBebanListState();
}

class _DataBebanListState extends State<DataBebanList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _bebans =
      FirebaseFirestore.instance.collection('beban');

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryLightColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildWidgetBebanList(widthScreen, heightScreen, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        child: Icon(
          Icons.add,
          color: kPrimaryLightColor,
        ),
        onPressed: () async {
          bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BebanForm(isEdit: false)));
          if (result != null && result) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Data Beban Berhasil Ditambahkan'),
              duration: Duration(seconds: 3),
            ));
            setState(() {});
          }
        },
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  Container _buildWidgetBebanList(
      double widthScreen, double heightScreen, BuildContext context) {
    return Container(
      width: widthScreen,
      height: heightScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Data Beban',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebaseFirestore
                  .collection('beban')
                  .orderBy('tanggal')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    Map<String, dynamic>? bbn =
                        documentSnapshot.data() as Map<String, dynamic>?;
                    String strDate = bbn!['tanggal'];
                    return Card(
                      child: ListTile(
                        title: Text(bbn['namasection']),
                        subtitle: Text(
                          bbn['ukur'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: false,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${int.parse(strDate.split(' ')[0])}',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              strDate.split(' ')[1],
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            // ignore: deprecated_member_use
                            return <PopupMenuEntry<String>>[]
                              ..add(PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Edit'),
                              ))
                              ..add(PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ));
                          },
                          onSelected: (String value) async {
                            if (value == 'edit') {
                              // TODO: fitur edit task
                              bool? result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return BebanForm(
                                    isEdit: true,
                                    bebanId: documentSnapshot.id,
                                    namaSec: bbn['namasection'],
                                    nilaiUkur: bbn['ukur'],
                                    tanggal: bbn['tanggal'],
                                  );
                                }),
                              );
                              if (result != null && result) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Data Beban Berhasil Diupdate'),
                                ));
                                setState(() {});
                              }
                            } else if (value == 'delete') {
                              // TODO: fitur hapus task
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Apakah kamu yakin?'),
                                      content: Text(
                                          'Apakah kamu ingin menghapus ${bbn['namasection']}'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            documentSnapshot.reference.delete();
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
