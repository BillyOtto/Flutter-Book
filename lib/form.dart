import 'package:flutter/material.dart';

class EditDataBook extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController judulController,
      authorController,
      penerbitController,
      kategoriController,
      sipnosisController,
      publishController;

  EditDataBook({
    required this.formkey,
    required this.judulController,
    required this.authorController,
    required this.penerbitController,
    required this.kategoriController,
    required this.sipnosisController,
    required this.publishController,
  });

  @override
  EditDataBookState createState() => EditDataBookState();
}

class EditDataBookState extends State<EditDataBook> {
  String? selectedBook;
  final kategoriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtJudul(),
            txtAuthor(),
            txtPenerbit(),
            txtKategori(),
            txtSipnosis(),
            txtPublish(),
          ],
        ),
      ),
    );
  }

  txtJudul() {
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
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.judulController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Judul Buku",
          prefixIcon: Icon(Icons.bookmark),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Judul Buku';
          }
          return null;
        },
      ),
    );
  }

  txtAuthor() {
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
      child: TextFormField(
        controller: widget.authorController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Nama Auhtor",
          prefixIcon: Icon(Icons.person),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Author';
          }
          return null;
        },
      ),
    );
  }

  txtPenerbit() {
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
      child: TextFormField(
        controller: widget.penerbitController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Penerbit",
          prefixIcon: Icon(Icons.menu_book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Penerbit';
          }
          return null;
        },
      ),
    );
  }

  txtSipnosis() {
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
      child: TextFormField(
        controller: widget.sipnosisController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Sipnosis Buku",
          prefixIcon: Icon(Icons.summarize),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }

  txtKategori() {
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
          labelText: 'Kategori Buku',
          prefixIcon: Icon(Icons.book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Kategori',
          style: TextStyle(fontSize: 14),
        ),
        items: items,
        value: selectedBook ?? widget.kategoriController.text,
        onChanged: (String? value) {
          setState(() {
            selectedBook = value;
            widget.kategoriController.text = selectedBook ?? '';
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih Kategori Buku.';
          }
          return null;
        },
      ),
    );
  }

  txtPublish() {
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
      child: TextFormField(
        controller: widget.publishController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Tanggal Terbit",
          prefixIcon: Icon(Icons.calendar_month),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        readOnly: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Tanggal Terbit Buku';
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 150),
            lastDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
          );
          if (pickedDate != null) {
            setState(() {
              widget.publishController.text =
                  "${pickedDate.toLocal()}".split(' ')[0];
            });
          }
        },
      ),
    );
  }
}
