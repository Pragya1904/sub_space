part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState extends HomeState{

  final List<Blog> blogs;

  HomeLoadedSuccessState({required this.blogs});
}

class HomeErrorState extends HomeState{}

class HomeNavigateToFavouritesPageActionState extends HomeActionState{}

class HomeNavigateToDetailsPageActionState extends HomeActionState{
  final Blog blog;
  HomeNavigateToDetailsPageActionState({required this.blog});
}

class HomeItemAddedToFavourites extends HomeActionState{}

class HomeItemRemovedFromFavourites extends HomeActionState{}