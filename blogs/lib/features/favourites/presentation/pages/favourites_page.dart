import 'package:blogs/features/details/presentation/pages/blog_page.dart';
import 'package:blogs/features/favourites/presentation/manager/favourites_bloc.dart';
import 'package:blogs/features/favourites/presentation/widgets/favourites_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);
  static const String id="favourites_page";
  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final FavouritesBloc favBloc=FavouritesBloc();
  @override
  void initState() {
    // TODO: implement initState
   favBloc.add(FavouritesInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesBloc,FavouritesState>(
      bloc: favBloc,
      listenWhen: (prev,curr)=> curr is FavouritesActionState,
      buildWhen: (prev,curr)=> curr is !FavouritesActionState,
        builder: (context,state){
        switch(state.runtimeType)
        {
          case FavouritesLoadingState:
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                //centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(onPressed: (){
                  favBloc.add(FavouritesNavigateToHomeBtnClickedEvent());
                }, icon: Icon(Icons.arrow_back)),
                title: const Text('My Favourites', style: kTitleTextStyle,softWrap: true,
                  maxLines: 1,),
              ),
              body: Center(
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            );
          case FavouritesLoadedSuccessState:
              final successState = state as FavouritesLoadedSuccessState;
              return Scaffold(
                backgroundColor: Colors.black,
                appBar:  AppBar(
                  //centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(onPressed: (){
                    favBloc.add(FavouritesNavigateToHomeBtnClickedEvent());
                  }, icon: Icon(Icons.arrow_back)),
                  title: const Text('My Favourites', style: kTitleTextStyle,softWrap: true,
                    maxLines: 1,),
                ),
                body: ListView.builder(itemCount: successState.favBlogs.length,itemBuilder: (context,index){
                  return FavouritesListTile(successState.favBlogs[index], context, favBloc);
                }) ,
              );
          case FavouritesErrorState:
            return Scaffold(
              backgroundColor: Colors.black,
              appBar:  AppBar(
                //centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(onPressed: (){
                  favBloc.add(FavouritesNavigateToHomeBtnClickedEvent());
                }, icon: Icon(Icons.arrow_back)),
                title: const Text('My Favourites', style: kTitleTextStyle,softWrap: true,
                  maxLines: 1,),
              ),
              body: Center(child: Text("Error Occured"),)
            );

          default:
            return Container();
        }
        },
        listener: (context,state){
      if (state is FavNavigateToHomePageActionState)
        {
          Navigator.pop(context);
        }
      else if(state is FavNavigateToDetailsPageActionState)
        {
          if(state.blog!=null)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage(blog: state.blog)));
            // Navigator.pushNamed(context, BlogPage.id,arguments: state.blog);
          }
          else
          {
            print("blog was found null in the state of FavAction state!!!");
          }
        }
      else if(state is FavouritesRemovedBlogActionState)
        {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed From Favourites")));
        }
    });
  }
}
