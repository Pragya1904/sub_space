import '../models/blog_model.dart';

class FavoritesRepository {
  final List<Blog> _favoriteBlogs = [];

  List<Blog> get favoriteBlogs => _favoriteBlogs;

  void addToFavorites(Blog blog) {
    if (!_favoriteBlogs.contains(blog)) {
      _favoriteBlogs.add(blog);
    }
  }

  void removeFromFavorites(Blog blog) {
    _favoriteBlogs.remove(blog);
  }

  bool isFavorite(Blog blog) {
    return _favoriteBlogs.contains(blog);
  }
}

// Use a singleton pattern to ensure a single instance of the repository
final favoritesRepository = FavoritesRepository();
