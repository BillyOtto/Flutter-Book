import 'dart:convert';
import 'dart:async';
import 'package:perpus2/forminput.dart';
import 'package:flutter/material.dart';
import 'package:perpus2/models/mbook.dart';
import 'package:perpus2/models/api.dart';
import 'package:http/http.dart' as http;
import 'details.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<ModelBook>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ModelBook>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body);
      return items.map<ModelBook>((json) => ModelBook.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Book",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<ModelBook>>(
          future: sw,
          builder:
              (BuildContext context, AsyncSnapshot<List<ModelBook>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No data found");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text(
                      "${data.judul} - ${data.sipnosis}",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategori: ${data.kategori}"),
                        Text("Publish Date: ${data.publish}"),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailBook(sw: data)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormTambah()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
