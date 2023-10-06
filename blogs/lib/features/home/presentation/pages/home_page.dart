import 'package:blogs/features/details/presentation/pages/blog_page.dart';
import 'package:blogs/features/favourites/presentation/pages/favourites_page.dart';
import 'package:blogs/features/home/presentation/manager/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../core/models/blog_model.dart';
import '../../../../core/services/api_services.dart';
import '../widgets/custom_list_tile.dart';
import 'package:bloc/bloc.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const id = 'home_page';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  //ApiService client=ApiService();
  final HomeBloc homeBloc=HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeBloc,HomeState>(
        bloc: homeBloc,
        listenWhen: (prev,curr)=>curr is HomeActionState,
        buildWhen: (prev,curr)=>curr is !HomeActionState,
        builder: (context,state){
              switch(state.runtimeType)
              {
                case HomeLoadingState:
                  return Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: const Text('Subspace Blog Mania', style: kTitleTextStyle,),
                      actions: [
                        IconButton(onPressed: (){
                          homeBloc.add(HomeFavouritesBtnNavigateEvent());
                          print("fav btn pressed");
                          setState(){}
                        }, icon:const Icon(Icons.favorite_border),color: Colors.white,)
                      ],
                    ),
                    body: Center(
                      child: CircularProgressIndicator(color: Colors.teal),
                    ),
                  );
                case HomeLoadedSuccessState:
                  final successState =state as HomeLoadedSuccessState;
                  return Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        title: const Text('Subspace Blog Mania', style: kTitleTextStyle,),
                        actions: [
                          IconButton(onPressed: (){
                            homeBloc.add(HomeFavouritesBtnNavigateEvent());
                            print("fav btn pressed");
                            //setState(){}
                          }, icon:const Icon(Icons.favorite_border),color: Colors.white,)
                        ],
                      ),
                      body: ListView.builder(itemCount: successState.blogs.length,itemBuilder: (context,index){
                              return customListTile(successState.blogs[index],context,homeBloc);
                             }, ),
                      // body : FutureBuilder<List<Blog>>(
                      //   builder : (context,AsyncSnapshot<List<Blog>> snapshot) {
                      //
                      //     if(snapshot.connectionState==ConnectionState.waiting)
                      //     {
                      //       return const Center(child: CircularProgressIndicator(),);
                      //     }
                      //     else if(snapshot.hasError)
                      //     {
                      //       return Text("hello dev the snapshot error is : ${snapshot.error}");
                      //     }
                      //     else if(snapshot.hasData && snapshot.data!=null)
                      //     {
                      //       List<Blog> blogs=snapshot.data!;
                      //       return ListView.builder(
                      //         itemCount: blogs.length,
                      //         itemBuilder: (context,index){
                      //           return customListTile(blogs[index],context,homeBloc);
                      //         },
                      //       );
                      //     }
                      //     else
                      //     {
                      //       return const Text("no blogs found");
                      //     }
                      //   }, future: client.getBlog(),
                      // )
                      );
                case HomeErrorState:
                  return Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: const Text('Subspace Blog Mania', style: kTitleTextStyle,),
                      actions: [
                        IconButton(onPressed: (){
                          homeBloc.add(HomeFavouritesBtnNavigateEvent());
                          print("fav btn pressed");
                          setState(){}
                        }, icon:const Icon(Icons.favorite_border),color: Colors.white,)
                      ],
                    ),
                    body: Center(
                      child: Text("Error Occured",style: kTitleTextStyle,),
                    ),
                  );
                default:
                  return Container(
                    child: Text("Default case in Home Page"),
                  );
              }

        },
        listener: (context,state){
          if(state is HomeNavigateToFavouritesPageActionState){
            Navigator.pushNamed(context, FavouritesPage.id);
          }
          else if(state is HomeNavigateToDetailsPageActionState)
          {
            if(state.blog!=null)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogPage(blog: state.blog)));
               // Navigator.pushNamed(context, BlogPage.id,arguments: state.blog);
              }
            else
              {
                print("blog was found null in the state of HomeAction state!!!");
              }
          }
          else if(state is HomeItemAddedToFavourites)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Marked As Favourite")));
            }
          else if(state is HomeItemRemovedFromFavourites)
            {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed from Favourites")));
            }
        });
  }

}


