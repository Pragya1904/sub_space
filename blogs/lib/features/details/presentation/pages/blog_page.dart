import 'dart:ui';

import 'package:blogs/features/details/presentation/manager/details_bloc.dart';
import 'package:blogs/features/favourites/presentation/pages/favourites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../../../constants.dart';
import '../../../../core/models/blog_model.dart';


class BlogPage extends StatefulWidget {
  const BlogPage({Key? key, required this.blog}) : super(key: key);
  final Blog blog;
  static const String id="articles";
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final DetailsBloc detailsBloc=DetailsBloc();

  @override
  void initState() {
    // TODO: implement initState
    detailsBloc.add(DetailsInitialEvent(blog: widget.blog));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return BlocConsumer<DetailsBloc,DetailsState>(
        bloc: detailsBloc,
        listenWhen:(prev,curr)=>curr is DetailsActionState ,
        buildWhen: (prev,curr)=>curr is !DetailsActionState,
        listener: (context,state){
          if(state is DetailsNavigateToHomePageActionState)
          {
            Navigator.pop(context);
          }
          else if(state is DetailsItemAddedToFavourites)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Marked As Favourite")));
          }
          else if(state is DetailsItemRemovedFromFavourites)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed from Favourites")));
          }
        },
        builder: (context,state)
        {
          switch(state.runtimeType)
          {
            case DetailsLoadingState:
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  //centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(onPressed: (){
                    detailsBloc.add(DetailsNavigateToHomePageEvent());
                  }, icon: Icon(Icons.arrow_back)),
                  title: const Text('Subspace Blog Mania', style: kTitleTextStyle,softWrap: true,
                    maxLines: 1,),
                ),
                body:const Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                ),
              );
            case DetailsLoadedSuccessState:
              final successState=state as DetailsLoadedSuccessState;
              return  Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  //centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(onPressed: (){
                    detailsBloc.add(DetailsNavigateToHomePageEvent());
                  }, icon: Icon(Icons.arrow_back)),
                  title: const Text('Subspace Blog Mania', style: kTitleTextStyle,softWrap: true,
                    maxLines: 1,),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                     ClipPath(
                       clipper: OvalBottomBorderClipper(),
                       child: Container(
                         height: size.height*0.25,
                         decoration: BoxDecoration(
                           image: DecorationImage(image: NetworkImage(widget.blog.imageUrl),fit: BoxFit.cover),
                         ),
                       ),
                     ),
                      SizedBox(
                        height: size.height*0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.01),
                        child: Text(widget.blog.title,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,),)),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.02),
                        child: InkWell(
                          onLongPress: ()async{
                            await Clipboard.setData(ClipboardData(text: "Copied Data"));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied To Clipboard")));
                          },
                          child: const Text("Long Press to Copy Content (add links if any)",style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.underline
                          ),)),
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.01),
                        child: Text(loremIpsum(words: 250,paragraphs: 4),style:const  TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.visible,
                          wordSpacing:3,
                          fontStyle: FontStyle.normal,
                        ),textAlign: TextAlign.justify,),),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      BlocBuilder<DetailsBloc,DetailsState>(
                        bloc: detailsBloc,
                        builder: (context,state) {
                          bool isMarkedFav=widget.blog.markedFav;
                          if(isMarkedFav)//state is DetailsItemAddedToFavourites)
                            {
                              return ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),minimumSize: MaterialStatePropertyAll((Size(size.width*0.5, size.height*0.07))),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)))),
                                  onPressed: (){
                                    if(isMarkedFav)
                                        detailsBloc.add(DetailsRemoveFromFavoritesBtnClickedEvent(blog: widget.blog));
                                  }, child: Text(
                                    isMarkedFav? "Remove from Favourites ":"Mark As Favourite",style: TextStyle(fontSize: 17,color:isMarkedFav ? Colors.red : Colors.deepPurple),));
                            }
                          else
                            {
                              return ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),minimumSize: MaterialStatePropertyAll((Size(size.width*0.5, size.height*0.07))),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)))),
                                  onPressed: (){
                                    if(!isMarkedFav)
                                      detailsBloc.add(DetailsFavoritesBtnClickedEvent(blog: widget.blog));
                                  }, child: Text(
                                    isMarkedFav? "Remove from Favourites ":"Mark As Favourite",style: TextStyle(fontSize: 17,color:isMarkedFav ? Colors.red : Colors.deepPurple),));
                            }
                        }
                      )
                      ,SizedBox(
                        height: size.height*0.03,
                      ),
                    ],
                  ),
                ),
              );
            case DetailsErrorState:
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  //centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(onPressed: (){
                    detailsBloc.add(DetailsNavigateToHomePageEvent());
                  }, icon: Icon(Icons.arrow_back)),
                  title: const Text('Subspace Blog Mania', style: kTitleTextStyle,softWrap: true,
                    maxLines: 1,),
                ),
                body:const Center(
                  child: Text("Error State encountered in details page")
                ),
              );
            default:
              return Container();
          }
        }
    );
  }
}
