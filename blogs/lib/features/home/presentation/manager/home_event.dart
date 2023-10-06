part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class HomeBlogCardBtnNavigateEvent extends HomeEvent{
  final Blog blog;
  HomeBlogCardBtnNavigateEvent({required this.blog});
}

class HomeFavouritesBtnNavigateEvent extends HomeEvent{}

class HomeFavoritesBtnClickedEvent extends HomeEvent{
  final Blog blog;
  HomeFavoritesBtnClickedEvent({required this.blog});
}

class HomeRemoveFromFavouritesBtnClickedEvent extends HomeEvent{
  final Blog blog;
  HomeRemoveFromFavouritesBtnClickedEvent({required this.blog});
}

