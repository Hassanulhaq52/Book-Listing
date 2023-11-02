// import 'package:book_listing/model/books_model.dart';
// import 'package:book_listing/screens/book_screen.dart';
// import 'package:book_listing/services/books_service.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   BooksService booksService = BooksService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Text(
//           'Hi Nick',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 20),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('images/profile.png'),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder<BooksModel?>(
//           future: booksService.getBooksData(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.data!.length,
//                 itemBuilder: (context, index) {
//                   final booksData = snapshot.data!.data![index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                             return BookScreen(bookData: booksData);
//                           }));
//                     },
//                     child: Card(
//                       color: Colors.blue,
//                       elevation: 8.0,
//                       child: Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                   color: Colors.white54, width: 2),
//                             ),
//                             width: 120,
//                             height: 140,
//                             child: Image.network(booksData.imageLink!,
//                                 fit: BoxFit.contain),
//                           ),
//                           const SizedBox(width: 10.0),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Text(booksData.title!),
//                                     const SizedBox(height: 5.0),
//                                     Text(booksData.price.toString()),
//                                     Container(
//                                       color: Colors.blue,
//                                       child: Text(booksData.title!),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 16.0),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../model/books_model.dart';
import '../services/books_service.dart';
import 'book_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BooksService booksService = BooksService();
  List<Data>? books;
  List<Data>? filteredBooks;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

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
      });
    }
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books!.where((book) {
        String title = book.title?.toLowerCase() ?? '';
        String author = book.author?.toLowerCase() ?? '';
        String lowercaseQuery = query.toLowerCase();
        return title.contains(lowercaseQuery) || author.contains(lowercaseQuery);
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
        title: Text(
          'Hi Nick',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: filterBooks,
              decoration: InputDecoration(
                labelText: 'Search by title or author',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                child: filteredBooks!.isEmpty
                    ? Center(child: Text('No results found.'))
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    childAspectRatio: 0.8, // You can adjust the aspect ratio as needed
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
                          Container(
                            // width: double.infinity,
                            // height: 200, // You can adjust the item height as needed
                            child: Image.network(
                              booksData.imageLink!,
                              fit: BoxFit.contain, // Ensure the entire picture is shown without cropping
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booksData.title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$${booksData.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )




            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:book_listing/model/books_model.dart';
// import 'package:book_listing/screens/book_screen.dart';
// import 'package:book_listing/services/books_service.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   BooksService booksService = BooksService();
//   List<Data>? books;
//   List<Data>? filteredBooks;
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = true;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     filteredBooks = [];
//     books = [];
//     fetchBooks();
//   }
//
//   void fetchBooks() async {
//     BooksModel? booksModel = await booksService.getBooksData();
//     if (booksModel != null && booksModel.data != null) {
//       setState(() {
//         books = booksModel.data!;
//         filteredBooks = List.from(books!);
//         isLoading = false;
//       });
//     }
//   }
//
//   void filterBooks(String query) {
//     setState(() {
//       filteredBooks = books!.where((book) {
//         String title = book.title?.toLowerCase() ?? '';
//         String author = book.author?.toLowerCase() ?? '';
//         String lowercaseQuery = query.toLowerCase();
//         return title.contains(lowercaseQuery) ||
//             author.contains(lowercaseQuery);
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Text(
//           'Hi Nick',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 20),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('images/profile.png'),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               onChanged: filterBooks,
//               decoration: InputDecoration(
//                 labelText: 'Search by title or author',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             isLoading
//                 ? Expanded(child: Center(child: CircularProgressIndicator()))
//                 : Expanded(
//                     child: filteredBooks!.isEmpty
//                         ? Center(child: Text('No results found.'))
//                         : ListView.builder(
//
//                             itemCount: filteredBooks!.length,
//                             itemBuilder: (context, index) {
//                               final booksData = filteredBooks![index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) {
//                                         return BookScreen(bookData: booksData);
//                                       },
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   color: Colors.blue,
//                                   elevation: 8.0,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           border: Border.all(
//                                             color: Colors.white54,
//                                             width: 2,
//                                           ),
//                                         ),
//                                         width: 120,
//                                         height: 140,
//                                         child: Image.network(
//                                           booksData.imageLink!,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10.0),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(booksData.title!),
//                                             const SizedBox(height: 5.0),
//                                             Text(booksData.price.toString()),
//                                             Container(
//                                               color: Colors.blue,
//                                               child: Text(booksData.title!),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:book_listing/model/books_model.dart';
// import 'package:book_listing/screens/book_screen.dart';
// import 'package:book_listing/services/books_service.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   BooksService booksService = BooksService();
//   late List<Data> books;
//   late List<Data> filteredBooks;
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     filteredBooks = [];
//     books = [];
//     fetchBooks();
//   }
//
//   void fetchBooks() async {
//     BooksModel? booksModel = await booksService.getBooksData();
//     if (booksModel != null && booksModel.data != null) {
//       setState(() {
//         books = booksModel.data!;
//       });
//     }
//   }
//
//   void filterBooks(String query) {
//     setState(() {
//       filteredBooks = books.where((book) {
//         String title = book.title?.toLowerCase() ?? '';
//         String author = book.author?.toLowerCase() ?? '';
//         String lowercaseQuery = query.toLowerCase();
//         return title.contains(lowercaseQuery) || author.contains(lowercaseQuery);
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Text(
//           'Hi Nick',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 20),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('images/profile.png'),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               onChanged: filterBooks,
//               decoration: InputDecoration(
//                 labelText: 'Search by title or author',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Expanded(
//               child: filteredBooks.isEmpty
//                   ? Center(child: Text('No results found.'))
//                   : ListView.builder(
//                 itemCount: filteredBooks.length,
//                 itemBuilder: (context, index) {
//                   final booksData = filteredBooks[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return BookScreen(bookData: booksData);
//                           },
//                         ),
//                       );
//                     },
//                     child: Card(
//                       color: Colors.blue,
//                       elevation: 8.0,
//                       child: Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: Colors.white54,
//                                 width: 2,
//                               ),
//                             ),
//                             width: 120,
//                             height: 140,
//                             child: Image.network(
//                               booksData.imageLink!,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           const SizedBox(width: 10.0),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(booksData.title!),
//                                 const SizedBox(height: 5.0),
//                                 Text(booksData.price.toString()),
//                                 Container(
//                                   color: Colors.blue,
//                                   child: Text(booksData.title!),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:book_listing/screens/book_screen.dart';
// import 'package:book_listing/services/books_service.dart';
// import 'package:flutter/material.dart';
//
// import '../model/books_model.dart';
//
// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   BooksService booksService = BooksService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Text(
//           'Hi Nick',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 20),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('images/profile.png'),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder<BooksModel?>(
//           future: booksService.getBooksData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.data!.length,
//                 itemBuilder: (context, index) {
//                   final booksData = snapshot.data!.data![index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return BookScreen(bookData: booksData);
//                           },
//                         ),
//                       );
//                     },
//                     child: Card(
//                       color: Colors.blue,
//                       elevation: 8.0,
//                       child: Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: Colors.white54,
//                                 width: 2,
//                               ),
//                             ),
//                             width: 120,
//                             height: 140,
//                             child: Image.network(
//                               booksData.imageLink!,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           const SizedBox(width: 10.0),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(booksData.title!),
//                                 const SizedBox(height: 5.0),
//                                 Text(booksData.price.toString()),
//                                 Container(
//                                   color: Colors.blue,
//                                   child: Text(booksData.title!),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('No data available.'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }