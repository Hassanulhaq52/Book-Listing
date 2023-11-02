// import 'package:book_listing/model/books_model.dart';
// import 'package:flutter/material.dart';
//
// class BookScreen extends StatefulWidget {
//   BooksModel bookData;
//
//   BookScreen({super.key, required this.bookData});
//   @override
//   State<BookScreen> createState() => _BookScreenState();
// }
//
// class _BookScreenState extends State<BookScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.bookData),
//       ),
//       body: Center(
//         child: Image.network(widget.bookData),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

import '../model/books_model.dart';

class BookScreen extends StatelessWidget {
  final Data bookData;

  BookScreen({required this.bookData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookData.title ?? ''),
      ),
      body: Center(
        child: Image.network(bookData.imageLink ?? ''),
      ),
    );
  }
}

