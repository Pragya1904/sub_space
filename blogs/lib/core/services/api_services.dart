import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/blog_model.dart';

class ApiService
{
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> getBlog() async{
    try{
        final response = await http.get(Uri.parse(url), headers: {
          'x-hasura-admin-secret': adminSecret,
        });
        if(response.statusCode==200)
          {
            Map<String,dynamic> json=jsonDecode(response.body);
            List<dynamic> body=json["blogs"];
           // print(body);
            print("********************************************");
            List<Blog> blogs=body.map((dynamic item) => Blog.fromJson(item)).toList();
            return blogs;
          }
        else
          {
            print("response code is not 200");
            throw("couldn't fetch the blogs");
          }
    }
    catch(exception){

        print(exception);
        print("Error during fetching response from api check ApiService class!!");

    }
    return [];
  }
}