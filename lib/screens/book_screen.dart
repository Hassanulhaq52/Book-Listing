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

import 'package:book_listing_app/screens/home_screen.dart';
import 'package:book_listing_app/utils/styles.dart';
import 'package:flutter/material.dart';
import '../model/books_model.dart';
import '../widgets/book_info.dart';

class BookScreen extends StatelessWidget {
  final Data bookData;

  BookScreen({required this.bookData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [

              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(bookData.imageLink ?? '')),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Text(
                                'Rating',
                                style: Styles.keyStyle,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              // Text('Stars'),
                              RatingStars(),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Reviews',
                                style: Styles.keyStyle,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text('(88)'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Price',
                                style: Styles.keyStyle,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text('\$${bookData.price}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${bookData.title}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 30),
                  BookInfo(infoKey: 'Author: ', value: '${bookData.author}'),
                  BookInfo(infoKey: 'Country: ', value: '${bookData.country}'),
                  BookInfo(
                      infoKey: 'Language: ', value: '${bookData.language}'),
                  BookInfo(infoKey: 'Year: ', value: bookData.year.toString()),
                  BookInfo(
                      infoKey: 'Pages: ', value: bookData.pages.toString()),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('View Details',
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset('images/arrow.png')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
