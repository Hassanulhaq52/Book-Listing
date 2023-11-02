import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/books_model.dart';

class BooksService {
  Future<BooksModel?> getBooksData() async {
    String baseURL = 'https://books-list-api.vercel.app/books';
    try {
      Uri url = Uri.parse(baseURL);
      http.Response response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-api-key': '#b0@6hX8YasCq6^unOaPw1tqR'
      });
      debugPrint('Response status: ${response.statusCode}');
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        BooksModel booksModel = BooksModel.fromJson(body);
        debugPrint('Response body: ${response.body}');
        return booksModel;
      } else {
        debugPrint('ERROR :$response.statusCode');
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
