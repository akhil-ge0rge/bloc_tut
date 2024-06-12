import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc_tut/post/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> fetchPostAPI() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;

        return body.map((e) {
          log(e.toString());
          return PostModel.fromJson(e);
        }).toList();
      }
      return [];
    } on SocketException {
      throw Exception("Error while Fetching data");
    } on TimeoutException {
      throw Exception("Error while Fetching data");
    }
  }
}
