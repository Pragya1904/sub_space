part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent {}

class FavouritesInitialEvent extends FavouritesEvent{}

class FavouritesNavigateToHomeBtnClickedEvent extends FavouritesEvent{}

class FavouritesNavigateToDetailsCardClickedEvent extends FavouritesEvent{
  final Blog blog;
  FavouritesNavigateToDetailsCardClickedEvent({required this.blog});
}

class FavRemoveFromFavouritesBtnClickedEvent extends FavouritesEvent{
  final Blog blog;
  FavRemoveFromFavouritesBtnClickedEvent({required this.blog});
}