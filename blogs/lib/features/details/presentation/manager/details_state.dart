part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

abstract class  DetailsActionState extends DetailsState{}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState{}

class DetailsLoadedSuccessState extends DetailsState{
  final Blog blog;
  DetailsLoadedSuccessState({required this.blog});
}

class DetailsErrorState extends DetailsState{}

class DetailsItemAddedToFavourites extends DetailsActionState{}

class DetailsItemRemovedFromFavourites extends DetailsActionState{}

class DetailsNavigateToHomePageActionState extends DetailsActionState{}