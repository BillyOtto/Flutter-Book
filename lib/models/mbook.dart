class ModelBook {
  final int id;
  final String judul, author, penerbit, kategori, sipnosis, publish;
  ModelBook({
    required this.id,
    required this.judul,
    required this.author,
    required this.penerbit,
    required this.kategori,
    required this.sipnosis,
    required this.publish,
  });

  factory ModelBook.fromJson(Map<String, dynamic> json) {
    return ModelBook(
        id: json['id'],
        judul: json['judul'],
        author: json['author'],
        penerbit: json['penerbit'],
        kategori: json['kategori'],
        sipnosis: json['sipnosis'],
        publish: json['publish']);
  }
  Map<String, dynamic> toJson() => {
        'judul': judul,
        'author': author,
        'penerbit': penerbit,
        'kategori': kategori,
        'sipnosis': sipnosis,
        'publish': publish,
      };
}
