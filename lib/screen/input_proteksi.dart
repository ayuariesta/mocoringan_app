import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:mocoringan_app/helpers.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocoringan_app/constants.dart';
import 'package:intl/intl.dart';

class ProteksiForm extends StatefulWidget {
  final bool isEdit;
  final String proteksiId;
  final String namaSection;
  final String tanggalPengecekan;
  final String arusFL;

  const ProteksiForm({
    required this.isEdit,
    this.proteksiId = '',
    this.namaSection = '',
    this.tanggalPengecekan = '',
    this.arusFL = '',
  });

  @override
  State<ProteksiForm> createState() => _ProteksiFormState();
}

class _ProteksiFormState extends State<ProteksiForm> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController sectionController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController arusController = TextEditingController();

  late double widthScreen;
  late double heightScreen;
  DateTime tanggal = DateTime.now().add(Duration(days: 1));
  bool isLoading = false;

  @override
  void initState() {
    if (widget.isEdit) {
      tanggal = DateFormat('dd MMMM yyyy').parse(widget.tanggalPengecekan);
      sectionController.text = widget.namaSection;
      tanggalController.text = widget.tanggalPengecekan;
      arusController.text = widget.arusFL;
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
                      : _buildWidgetButtonCreateProteksi(),
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
          SizedBox(height: 16.0),
          Text(
            widget.isEdit ? 'Edit\nTask' : 'Create\nNew Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: sectionController,
            decoration: InputDecoration(
              labelText: 'Nama Section',
            ),
            style: TextStyle(fontSize: 18.0),
          ),
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
            TextField(
              controller: arusController,
              decoration: InputDecoration(
                label: Text('Arus Fuse Link'),
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.electric_bolt),
                  ],
                ),
              ),
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(
                label: Text('Tanggal'),
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.today),
                  ],
                ),
              ),
              style: TextStyle(fontSize: 18.0),
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
                      DateFormat('dd MMMM yyyy').format(today);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonCreateProteksi() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        child: Text(widget.isEdit ? 'UPDATE TASK' : 'CREATE TASK'),
        onPressed: () async {
          String section = sectionController.text;
          String arus = arusController.text;
          String date = tanggalController.text;
          setState(() => isLoading = true);
          if (widget.isEdit) {
            DocumentReference documentReference =
                firebaseFirestore.doc('proteksi/${widget.proteksiId}');
            firebaseFirestore.runTransaction((transaction) async {
              DocumentSnapshot protek =
                  await transaction.get(documentReference);
              if (protek.exists) {
                await transaction.update(
                  documentReference,
                  <String, dynamic>{
                    'section': section,
                    'arus': arus,
                    'date': tanggal,
                  },
                );
              }
            });
          } else {
            CollectionReference proteksi =
                firebaseFirestore.collection('proteksi');
            DocumentReference result = await proteksi.add(<String, dynamic>{
              'section': section,
              'arus': arus,
              'date': date,
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