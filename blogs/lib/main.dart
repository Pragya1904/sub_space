import 'package:blogs/features/details/presentation/pages/blog_page.dart';
import 'package:blogs/features/favourites/presentation/pages/favourites_page.dart';
import 'package:blogs/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'core/models/blog_model.dart';
import 'core/repositories/favourites_repo.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

void setupDependencies()
{
  final getIt=GetIt.instance;

  getIt.registerSingleton<FavoritesRepository>(FavoritesRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Blog blog=Blog(imageUrl: "", title: "", id: "",markedFav: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:  ColorScheme.dark(),
        useMaterial3: true,
      ),
      initialRoute: Home.id,
      routes: {
        Home.id : (context) =>const Home(),
        BlogPage.id: (context)=> BlogPage( blog:blog,),
        FavouritesPage.id: (context)=> const FavouritesPage(),
      },
    );
  }
}

