import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class FormTambah extends StatefulWidget {
  const FormTambah({super.key});
  @override
  State<StatefulWidget> createState() => FormTambahState();
}

class FormTambahState extends State<FormTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController judulController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController sipnosisController = TextEditingController();
  TextEditingController publishController = TextEditingController();

  String? selectedBook;
  Future createSw() async {
    return await http.post(Uri.parse(BaseUrl.tambah), body: {
      'judul': judulController.text,
      'author': authorController.text,
      'penerbit': penerbitController.text,
      "sipnosis": sipnosisController.text,
      'kategori': kategoriController.text,
      "publish": publishController.text,
    });
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Data Buku",
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
      body: Container(
        child: Column(
          children: [
            _textboxJudul(),
            _textboxAuthor(),
            _textboxPenerbit(),
            _textboxKategori(),
            _textboxSipnosis(),
            _textboxPublish(),
            const SizedBox(height: 20.0),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  _textboxJudul() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Judul Buku",
          prefixIcon: Icon(Icons.book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: judulController,
      ),
    );
  }

  _textboxAuthor() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Nama Author",
          prefixIcon: Icon(Icons.person),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: authorController,
      ),
    );
  }

  _textboxPenerbit() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Penerbit",
          prefixIcon: Icon(Icons.menu_book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: penerbitController,
      ),
    );
  }

  _textboxKategori() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(value: 'Novel', child: Text('Novel')),
      DropdownMenuItem(value: 'Histori', child: Text('Histori')),
      DropdownMenuItem(value: 'Cerita', child: Text('Cerita Rakyat')),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Kategori',
          prefixIcon: Icon(Icons.book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Kategori Buku',
          style: TextStyle(fontSize: 14),
        ),
        items: items,
        value: selectedBook ??
            (kategoriController.text.isNotEmpty
                ? kategoriController.text
                : null),
        onChanged: (String? value) {
          setState(() {
            selectedBook = value;
            kategoriController.text = selectedBook ?? '';
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Kategori Buku';
          }
          return null;
        },
      ),
    );
  }

  _textboxSipnosis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Sipnosis Buku",
          prefixIcon: Icon(Icons.summarize),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: sipnosisController,
      ),
    );
  }

  _textboxPublish() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: publishController,
        decoration: const InputDecoration(
          labelText: "Tanggal Terbit",
          prefixIcon: Icon(Icons.calendar_month),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            setState(() {
              publishController.text = "${pickedDate.toLocal()}".split(' ')[0];
            });
          }
        },
      ),
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
