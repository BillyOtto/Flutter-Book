import 'dart:convert';

import 'package:perpus2/models/mbook.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perpus2/models/api.dart';
import 'package:http/http.dart' as http;

import 'package:perpus2/form.dart';

class Edit extends StatefulWidget {
  final ModelBook sw;

  Edit({required this.sw});

  @override
  State<StatefulWidget> createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController judulController,
      authorController,
      penerbitController,
      kategoriController,
      sipnosisController,
      publishController;

  Future editSw() async {
    return await http.post(Uri.parse(BaseUrl.edit), body: {
      "id": widget.sw.id.toString(),
      "judul": judulController.text,
      "author": authorController.text,
      "penerbit": penerbitController.text,
      "kategori": kategoriController.text,
      "sipnosis": sipnosisController.text,
      "publish": publishController.text,
    });
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    judulController = TextEditingController(text: widget.sw.judul);
    authorController = TextEditingController(text: widget.sw.author);
    penerbitController = TextEditingController(text: widget.sw.penerbit);
    kategoriController = TextEditingController(text: widget.sw.kategori);
    sipnosisController = TextEditingController(text: widget.sw.sipnosis);
    publishController = TextEditingController(text: widget.sw.publish);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Buku",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
        child: Text("Update"),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        onPressed: () {
          _onConfirm(context);
        },
      )),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: EditDataBook(
            formkey: formkey,
            judulController: judulController,
            authorController: authorController,
            penerbitController: penerbitController,
            kategoriController: kategoriController,
            sipnosisController: sipnosisController,
            publishController: publishController,
          ),
        ),
      ),
    );
  }
}
