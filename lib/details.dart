import 'package:perpus2/models/mbook.dart';
import 'package:perpus2/models/api.dart';
import 'package:perpus2/edit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class DetailBook extends StatefulWidget {
  final ModelBook sw;
  DetailBook({required this.sw});

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  void deleteBook(context) async {
    http.Response response = await http.post(Uri.parse(BaseUrl.hapus), body: {
      'id': widget.sw.id.toString(),
    });
    pesan() {
      Fluttertoast.showToast(
          msg: "Penghapusan Data Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    final data = json.decode((response.body));
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Apakah Anda yakin menghapus data ini?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel),
              ),
              ElevatedButton(
                  onPressed: () => deleteBook(context),
                  child: Icon(Icons.check_circle))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Buku',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Add this widget to enable scrolling
        child: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            children: [
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  leading: Icon(Icons.bookmark, color: Colors.blue),
                  title: Text(
                    "Judul:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.sw.judul,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.green),
                  title: Text(
                    "Author:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.sw.author,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  leading: Icon(Icons.menu_book, color: Colors.green),
                  title: Text(
                    "Penerbit:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.sw.penerbit,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  leading: Icon(Icons.library_books, color: Colors.purple),
                  title: Text(
                    "Kategori:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.sw.kategori,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  leading: Icon(Icons.description, color: Colors.orange),
                  title: Text(
                    "Sipnosis:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.sw.sipnosis,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListTile(
                  leading: Icon(Icons.date_range, color: Colors.red),
                  title: Text(
                    "Tanggal Publish:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    widget.sw.publish,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Edit(sw: widget.sw)),
          );
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
