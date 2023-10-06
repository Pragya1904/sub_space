import 'dart:convert';

import 'package:blogs/features/details/presentation/pages/blog_page.dart';

class Blog {
  Blog({
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.markedFav,
  });

  String imageUrl = "";
  String title = "";
  String id = "";
  bool markedFav=false;


  factory Blog.fromJson(Map<String,dynamic> json)=>Blog(
    title: json["title"] ?? "no title",
    id: json["id"] ?? "no id",
    imageUrl: json["image_url"] ?? "no image",
    markedFav: false
  );

}