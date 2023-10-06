import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blogs/core/repositories/favourites_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/blog_model.dart';
import '../../../../core/services/api_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeFavouritesBtnNavigateEvent>(homeFavouritesBtnNavigateEvent);
    on<HomeBlogCardBtnNavigateEvent>(homeBlogCardBtnNavigateEvent);
    on<HomeFavoritesBtnClickedEvent>(homeFavoritesBtnClickedEvent);
    on<HomeRemoveFromFavouritesBtnClickedEvent>(homeRemoveFromFavouritesBtnClickedEvent);
  }

  FutureOr<void>  homeInitialEvent(HomeInitialEvent event,Emitter<HomeState> emit) async {
    ApiService client=ApiService();
      emit(HomeLoadingState());

    final blogs=await client.getBlog();
      emit(HomeLoadedSuccessState(blogs: blogs));
  }


  FutureOr<void> homeFavouritesBtnNavigateEvent(HomeFavouritesBtnNavigateEvent event, Emitter<HomeState> emit) {
    print("navigate to favourites page");
    emit(HomeNavigateToFavouritesPageActionState());
  }

  FutureOr<void> homeBlogCardBtnNavigateEvent(HomeBlogCardBtnNavigateEvent event, Emitter<HomeState> emit) {
    print("navigate inside the selected blog article");
    emit(HomeNavigateToDetailsPageActionState(blog: event.blog));
  }

  FutureOr<void> homeFavoritesBtnClickedEvent(HomeFavoritesBtnClickedEvent event, Emitter<HomeState> emit) {
    print("blog marked as favourite");
   event.blog.markedFav=!event.blog.markedFav;
    favoritesRepository.favoriteBlogs.add(event.blog);
    emit(HomeItemAddedToFavourites());

  }

  FutureOr<void> homeRemoveFromFavouritesBtnClickedEvent(HomeRemoveFromFavouritesBtnClickedEvent event, Emitter<HomeState> emit) {
    print("blog removed from favourites");
    event.blog.markedFav=!event.blog.markedFav;
    favoritesRepository.favoriteBlogs.remove(event.blog);
    emit(HomeItemRemovedFromFavourites());
  }
}

