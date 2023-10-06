

import 'package:blogs/features/details/presentation/pages/blog_page.dart';
import 'package:blogs/features/favourites/presentation/manager/favourites_bloc.dart';
import 'package:blogs/features/home/presentation/manager/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/blog_model.dart';


Widget FavouritesListTile(Blog blog,BuildContext context,FavouritesBloc favBlog)
{
  return GestureDetector(
    onTap: (){
      favBlog.add(FavouritesNavigateToDetailsCardClickedEvent(blog: blog));
    },
    child: Container(
      margin:  EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
      //padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.0),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(blog.imageUrl),fit: BoxFit.cover),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.006),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(blog.title,style: const TextStyle(color: Colors.white),maxLines: 2,softWrap: true,)),
                BlocBuilder<FavouritesBloc,FavouritesState>(
                  bloc: favBlog,
                  builder: (context,state) {
                    bool isMarkedFav=blog.markedFav;
                    if(state is !FavouritesRemovedBlogActionState){
                        return IconButton(onPressed: (){
                          if(isMarkedFav)
                            favBlog.add(FavRemoveFromFavouritesBtnClickedEvent(blog: blog));
                        }, icon: Icon(Icons.favorite,color: Colors.red,));
                    }
                    else
                      {
                        return IconButton(onPressed: (){
                        }, icon: Icon(Icons.favorite,color: Colors.red,));
                      }

                  }
                )
              ],
            ),
          ),
          // Text(blog.imageUrl,style: const TextStyle(color: Colors.black),)
        ],
      ),
    ),
  );
}