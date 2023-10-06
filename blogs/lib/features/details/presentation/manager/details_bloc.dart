import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blogs/features/favourites/presentation/manager/favourites_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/blog_model.dart';
import '../../../../core/repositories/favourites_repo.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsNavigateToHomePageEvent>(detailsNavigateToHomePageEvent);
    on<DetailsInitialEvent>(detailsInitialEvent);
    on<DetailsFavoritesBtnClickedEvent>(detailsFavoritesBtnClickedEvent);
    on<DetailsRemoveFromFavoritesBtnClickedEvent>(detailsRemoveFromFavoritesBtnClickedEvent);
  }

  FutureOr<void> detailsInitialEvent(DetailsInitialEvent event, Emitter<DetailsState> emit) async {
      emit(DetailsLoadingState());
      final blog=await event.blog;
      emit(DetailsLoadedSuccessState(blog: blog));
  }

  FutureOr<void> detailsNavigateToHomePageEvent(DetailsNavigateToHomePageEvent event, Emitter<DetailsState> emit) {
    print("navigate back to Home page");
    emit(DetailsNavigateToHomePageActionState());
  }


  FutureOr<void> detailsFavoritesBtnClickedEvent(DetailsFavoritesBtnClickedEvent event, Emitter<DetailsState> emit) {
    print("blog marked as favourite");
    event.blog.markedFav=!event.blog.markedFav;
    favoritesRepository.favoriteBlogs.add(event.blog);
    emit(DetailsItemAddedToFavourites());

  }

  FutureOr<void> detailsRemoveFromFavoritesBtnClickedEvent(DetailsRemoveFromFavoritesBtnClickedEvent event, Emitter<DetailsState> emit) {
    print("blog removed from favourites");
    event.blog.markedFav=!event.blog.markedFav;
    favoritesRepository.favoriteBlogs.remove(event.blog);
    emit(DetailsItemRemovedFromFavourites());
  //  emit(FavouritesLoadedSuccessState(favBlogs: FavBlogs.favBlogs));

  }
}
