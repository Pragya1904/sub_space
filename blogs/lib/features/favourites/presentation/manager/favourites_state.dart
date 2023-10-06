part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesActionState extends FavouritesState{}

class FavouritesLoadingState extends FavouritesState{}

class FavouritesLoadedSuccessState extends FavouritesState{
  final List<Blog> favBlogs;

  FavouritesLoadedSuccessState({required this.favBlogs});
}

class FavouritesErrorState extends FavouritesState{}

class FavNavigateToHomePageActionState extends FavouritesActionState{}

class FavNavigateToDetailsPageActionState extends FavouritesActionState{
  final Blog blog;

  FavNavigateToDetailsPageActionState({required this.blog});

}

class FavouritesRemovedBlogActionState extends FavouritesActionState{}