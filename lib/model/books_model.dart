// class BooksModel {
//   List<Data>? data;
//   String? message;
//
//   BooksModel({this.data, this.message});
//
//   BooksModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Data {
//   String? author;
//   String? country;
//   String? imageLink;
//   String? language;
//   String? link;
//   int? pages;
//   String? title;
//   int? year;
//   int? price;
//   int? rating;
//   int? reviews;
//   bool? isLiked;
//
//   Data(
//       {this.author,
//         this.country,
//         this.imageLink,
//         this.language,
//         this.link,
//         this.pages,
//         this.title,
//         this.year,
//         this.price,
//         this.rating,
//         this.reviews,
//         this.isLiked});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     author = json['author'];
//     country = json['country'];
//     imageLink = json['imageLink'];
//     language = json['language'];
//     link = json['link'];
//     pages = json['pages'];
//     title = json['title'];
//     year = json['year'];
//     price = json['price'];
//     rating = json['rating'];
//     reviews = json['reviews'];
//     isLiked = json['is_liked'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['author'] = this.author;
//     data['country'] = this.country;
//     data['imageLink'] = this.imageLink;
//     data['language'] = this.language;
//     data['link'] = this.link;
//     data['pages'] = this.pages;
//     data['title'] = this.title;
//     data['year'] = this.year;
//     data['price'] = this.price;
//     data['rating'] = this.rating;
//     data['reviews'] = this.reviews;
//     data['is_liked'] = this.isLiked;
//     return data;
//   }
// }




class BooksModel {
  List<Data>? data;
  String? message;

  BooksModel({this.data, this.message});

  BooksModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? author;
  String? country;
  String? imageLink;
  String? language;
  String? link;
  int? pages;
  String? title;
  int? year;
  int? price;
  int? rating;
  int? reviews;
  bool? isLiked;

  Data({
    this.author,
    this.country,
    this.imageLink,
    this.language,
    this.link,
    this.pages,
    this.title,
    this.year,
    this.price,
    this.rating,
    this.reviews,
    this.isLiked,
  });

  Data.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    country = json['country'];
    imageLink = json['imageLink'];
    language = json['language'];
    link = json['link'];
    pages = json['pages'];
    title = json['title'];
    year = json['year'];
    price = json['price'];
    rating = json['rating'];
    reviews = json['reviews'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['country'] = country;
    data['imageLink'] = imageLink;
    data['language'] = language;
    data['link'] = link;
    data['pages'] = pages;
    data['title'] = title;
    data['year'] = year;
    data['price'] = price;
    data['rating'] = rating;
    data['reviews'] = reviews;
    data['is_liked'] = isLiked;
    return data;
  }
}