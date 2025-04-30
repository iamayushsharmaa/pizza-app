import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:internet/api/data/models/PostData.dart';

class PostRepository{

  static Future<List<PostData>> fetchPost() async {
    var client = http.Client();
    List<PostData> posts = [];
    try {
      var response = await client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List result = jsonDecode(response.body);
      for(int i=0; i<result.length; i++){
        PostData postData = PostData.fromJson(result[i] as Map<String, dynamic>);
        posts.add(postData);
      }
      return posts;
    }catch(e){
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {
            "title": "I dont want to become a teacher",
            "body": "fgkfashfjshdfsh",
            "userId": 34
          });
      if(response.statusCode == 201 && response.statusCode < 300){
        return true;
      }else{
        return false;
      }
    }catch(e){
      log(e.toString());
      return false;
    }
  }
}