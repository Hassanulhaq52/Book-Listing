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
        // isFavorite = List.generate(books!.length, (index) => false);
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextField(

                controller: searchController,
                onChanged: filterBooks,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  prefixIcon: Icon(Icons.search,color: Colors.black
                    ,),
                  contentPadding: EdgeInsets.all(12.0),

                  filled: true,
                  fillColor: Colors.grey[200], // Grey background color
                ),
              ),
            ),

            const SizedBox(height: 16.0),
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
                              childAspectRatio:
                                  0.5, // You can adjust the aspect ratio as needed
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
                                          top:
                                              8.0, // Adjust the top position of the container
                                          right:
                                              8.0, // Adjust the right position of the container
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Icon(
                                              isFavorite[index]
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border, // You can change this to your heart icon
                                              color: Colors.red,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 8.0),
                                    // Adjust the spacing between image and text
                                    Text(
                                      booksData.title!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RatingStars(),
                                        SizedBox(width: 10,),
                                        Text(
                                          '(88)'
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

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarIcon(),
        StarIcon(),
        StarIcon(),
        StarIcon(),
        Icon(
          Icons.star,
          color: Colors.grey.shade400,
          size: 20
        ),

      ],
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color: Colors.orangeAccent,
      size: 20,
    );
  }
}

// import 'package:flutter/material.dart';
//
// import '../model/books_model.dart';
// import '../services/books_service.dart';
// import 'book_screen.dart';
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
//               decoration: const InputDecoration(
//                 labelText: 'Search by title or author',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             isLoading
//                 ? const Expanded(child: Center(child: CircularProgressIndicator()))
//                 : Expanded(
//                 child: filteredBooks!.isEmpty
//                     ? const Center(child: Text('No results found.'))
//                     : GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, // 2 items per row
//                     childAspectRatio: 0.8, // You can adjust the aspect ratio as needed
//                   ),
//                   itemCount: filteredBooks!.length,
//                   itemBuilder: (context, index) {
//                     final booksData = filteredBooks![index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return BookScreen(bookData: booksData);
//                             },
//                           ),
//                         );
//                       },
//                       child: Column(
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.network(
//                             booksData.imageLink!,
//                             fit: BoxFit.contain, // Ensure the entire picture is shown without cropping
//                           ),
//                           Text(
//                             booksData.title!,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                               ),
//                               Icon(
//                                 Icons.star_border,
//                                 color: Colors.yellow,
//                               ),
//                             ],
//                           ),
//                           Text(
//                             '\$${booksData.price}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 )
//
//
//
//
//             ),
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
