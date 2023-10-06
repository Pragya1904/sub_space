part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class DetailsInitialEvent extends DetailsEvent{
  final Blog blog;
  DetailsInitialEvent({required this.blog});
}

class DetailsNavigateToHomePageEvent extends DetailsEvent{
}

class DetailsFavoritesBtnClickedEvent extends DetailsEvent{
  final Blog blog;
  DetailsFavoritesBtnClickedEvent({required this.blog});
}

class DetailsRemoveFromFavoritesBtnClickedEvent extends DetailsEvent{
  final Blog blog;
  DetailsRemoveFromFavoritesBtnClickedEvent({required this.blog});
}

