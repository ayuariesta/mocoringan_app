import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mocoringan_app/constants.dart';
import 'package:intl/intl.dart';

class BebanForm extends StatefulWidget {
  final bool isEdit;
  final String bebanId;
  final String namaSec;
  final String tanggal;
  final String nilaiUkur;

  const BebanForm({
    required this.isEdit,
    this.bebanId = '',
    this.namaSec = '',
    this.tanggal = '',
    this.nilaiUkur = '',
  });

  @override
  State<BebanForm> createState() => _BebanFormState();
}

class _BebanFormState extends State<BebanForm> {
  var bebanID = "";

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController namasectionController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController ukurController = TextEditingController();

  late double widthScreen;
  late double heightScreen;
  DateTime tanggal = DateTime.now().add(Duration(days: 1));
  bool isLoading = false;

  @override
  void initState() {
    if (widget.isEdit) {
      tanggal = DateFormat('dd MMMM yyyy').parse(widget.tanggal);
      namasectionController.text = widget.namaSec;
      tanggalController.text = widget.tanggal;
      ukurController.text = widget.nilaiUkur;
    } else {
      tanggalController.text = DateFormat('dd MMMM yyyy').format(tanggal);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    widthScreen = mediaQueryData.size.width;
    heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: _scaffoldState,
      backgroundColor: kPrimaryLightColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: widthScreen,
              height: heightScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildWidgetFormPrimary(),
                  SizedBox(height: 16.0),
                  _buildWidgetFormSecondary(),
                  isLoading
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  kPrimaryLightColor),
                            ),
                          ),
                        )
                      : _buildWidgetButtonCreateBeban(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFormPrimary() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            widget.isEdit ? 'Edit\nData Beban' : 'Create\nData Beban',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontSize: 25.0,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildWidgetFormSecondary() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 14.0),
            TextField(
              controller: namasectionController,
              decoration: InputDecoration(
                labelText: 'Nama Section',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(Icons.person),
                ),
              ),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 18.0),
            TextField(
              keyboardType: TextInputType.number,
              controller: ukurController,
              decoration: InputDecoration(
                label: Text('Nilai Pengukuran'),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(Icons.electric_bolt),
                ),
              ),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(
                label: Text('Tanggal'),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.calendar_month),
                ),
              ),
              style: TextStyle(fontSize: 14.0),
              readOnly: true,
              onTap: () async {
                DateTime today = DateTime.now();
                DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: tanggal,
                  firstDate: today,
                  lastDate: DateTime(2090),
                );
                if (datePicker != null) {
                  tanggal = datePicker;
                  tanggalController.text =
                      DateFormat('dd MMMM yyyy').format(tanggal);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonCreateBeban() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        child: Text(widget.isEdit ? 'UPDATE DATA' : 'SIMPAN'),
        onPressed: () async {
          String namasection = namasectionController.text;
          String ukur = ukurController.text;
          String tanggal = tanggalController.text;
          setState(() => isLoading = true);
          if (widget.isEdit) {
            DocumentReference documentReference =
                firebaseFirestore.doc('beban/${widget.bebanId}');
            firebaseFirestore.runTransaction((transaction) async {
              DocumentSnapshot beban = await transaction.get(documentReference);
              if (beban.exists) {
                await transaction.update(
                  documentReference,
                  <String, dynamic>{
                    'namasection': namasection,
                    'ukur': ukur,
                    'tanggal': tanggal,
                  },
                );
                Navigator.pop(context, true);
              }
            });
          } else {
            CollectionReference beban = firebaseFirestore.collection('beban');
            DocumentReference result = await beban.add(<String, dynamic>{
              'namasection': namasection,
              'ukur': ukur,
              'tanggal': tanggal,
            });
            if (result.id != null) {
              Navigator.pop(context, true);
            }
          }
        },
      ),
    );
  }

  void _showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
