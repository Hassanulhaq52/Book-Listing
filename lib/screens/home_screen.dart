import 'package:flutter/material.dart';

import '../model/books_model.dart';
import '../services/books_service.dart';
import '../widgets/rating_stars.dart';
import 'book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BooksService booksService = BooksService();
  List<Data>? books;
  List<Data>? filteredBooks;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  List<bool> isFavorite = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = [];
    books = [];
    fetchBooks();
  }

  void fetchBooks() async {
    BooksModel? booksModel = await booksService.getBooksData();
    if (booksModel != null && booksModel.data != null) {
      setState(() {
        books = booksModel.data!;
        filteredBooks = List.from(books!);
        isLoading = false;
        isFavorite = List.generate(books!.length, (index) => index % 2 == 0);
      });
    }
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books!.where((book) {
        String title = book.title?.toLowerCase() ?? '';
        String author = book.author?.toLowerCase() ?? '';
        String lowercaseQuery = query.toLowerCase();
        return title.contains(lowercaseQuery) ||
            author.contains(lowercaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Hi Nick',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'images/profile.png',
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextField(
                controller: searchController,
                onChanged: filterBooks,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  contentPadding:
                      const EdgeInsets.only(left: 12, right: 12, top: 15),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: filteredBooks!.isEmpty
                        ? const Center(child: Text('No results found.'))
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 items per row
                              childAspectRatio: 0.5,
                            ),
                            itemCount: filteredBooks!.length,
                            itemBuilder: (context, index) {
                              final booksData = filteredBooks![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BookScreen(bookData: booksData);
                                      },
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.41,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: Image.network(
                                              booksData.imageLink!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.0,
                                          right: 8.0,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Icon(
                                              isFavorite[index]
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      booksData.title!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    const Row(
                                      children: [
                                        RatingStars(),
                                        SizedBox(width: 10),
                                        Text('(88)'),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '\$${booksData.price}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
