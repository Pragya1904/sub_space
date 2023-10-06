import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blogs/core/repositories/favourites_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/blog_model.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesInitialEvent>(favouritesInitialEvent);
    on<FavouritesNavigateToHomeBtnClickedEvent>(favouritesNavigateToHomeBtnClickedEvent);
    on<FavRemoveFromFavouritesBtnClickedEvent>(favRemoveFromFavouritesBtnClickedEvent);
    on<FavouritesNavigateToDetailsCardClickedEvent>(favouritesNavigateToDetailsCardClickedEvent);
  }

  FutureOr<void> favouritesInitialEvent(FavouritesInitialEvent event, Emitter<FavouritesState> emit) {
    emit(FavouritesLoadingState());

    emit(FavouritesLoadedSuccessState(favBlogs: favoritesRepository.favoriteBlogs.map((e) => Blog(
      title: e.title,
      imageUrl: e.imageUrl,
      id: e.id,
      markedFav: true
    )).toList()));

  }

  FutureOr<void> favouritesNavigateToHomeBtnClickedEvent(FavouritesNavigateToHomeBtnClickedEvent event, Emitter<FavouritesState> emit) {
      emit(FavNavigateToHomePageActionState());
  }

  FutureOr<void> favRemoveFromFavouritesBtnClickedEvent(FavRemoveFromFavouritesBtnClickedEvent event, Emitter<FavouritesState> emit) {
      print("blog removed from favourites");
      favoritesRepository.favoriteBlogs.remove(event.blog);
      event.blog.markedFav=!event.blog.markedFav;
      emit(FavouritesRemovedBlogActionState());
      emit(FavouritesLoadedSuccessState(favBlogs: favoritesRepository.favoriteBlogs));
  }

  FutureOr<void> favouritesNavigateToDetailsCardClickedEvent(FavouritesNavigateToDetailsCardClickedEvent event, Emitter<FavouritesState> emit) {
    emit(FavNavigateToDetailsPageActionState(blog: event.blog));
  }
}
