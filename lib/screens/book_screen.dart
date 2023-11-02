import 'package:book_listing_app/screens/home_screen.dart';
import 'package:book_listing_app/utils/styles.dart';
import 'package:flutter/material.dart';
import '../model/books_model.dart';
import '../widgets/book_info.dart';
import '../widgets/details_button.dart';
import '../widgets/rating_stars.dart';

class BookScreen extends StatelessWidget {
  final Data bookData;

  const BookScreen({super.key, required this.bookData});

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
                elevation: 10.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(bookData.imageLink ?? '')),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Rating', style: Styles.keyStyle),
                              SizedBox(height: 7),
                              RatingStars(),
                            ],
                          ),
                          const Column(
                            children: [
                              Text('Reviews', style: Styles.keyStyle),
                              SizedBox(height: 7),
                              Text('(88)'),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Price', style: Styles.keyStyle),
                              const SizedBox(height: 7),
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
                  const SizedBox(height: 30),
                  BookInfo(infoKey: 'Author: ', value: '${bookData.author}'),
                  BookInfo(infoKey: 'Country: ', value: '${bookData.country}'),
                  BookInfo(
                      infoKey: 'Language: ', value: '${bookData.language}'),
                  BookInfo(infoKey: 'Year: ', value: bookData.year.toString()),
                  BookInfo(
                      infoKey: 'Pages: ', value: bookData.pages.toString()),
                  const SizedBox(height: 20),
                  const DetailsButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
