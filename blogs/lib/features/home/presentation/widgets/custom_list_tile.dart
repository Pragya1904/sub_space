

import 'package:blogs/features/details/presentation/pages/blog_page.dart';
import 'package:blogs/features/home/presentation/manager/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/blog_model.dart';


Widget customListTile(Blog blog,BuildContext context,HomeBloc homeBloc)
{
  return GestureDetector(
    onTap: (){
    //  Navigator.pushNamed(context, blog.id,arguments: blog);
      homeBloc.add(HomeBlogCardBtnNavigateEvent(blog: blog));
      //Navigator.push(context , MaterialPageRoute(builder: (context)=>BlogPage(blog)));
    },
    child: Container(
      margin:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
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
                BlocBuilder<HomeBloc,HomeState>(
                  bloc: homeBloc,
                  builder: (context,state){
                    bool isMarkedFav=blog.markedFav;
                  if( state is HomeItemAddedToFavourites )
                   {
                     return IconButton(
                      onPressed: () {
                        if(isMarkedFav)
                          homeBloc.add(HomeRemoveFromFavouritesBtnClickedEvent(blog: blog));
                      },
                      icon: Icon(
                        isMarkedFav ? Icons.favorite : Icons.favorite_border ,
                        color: isMarkedFav ? Colors.red : Colors.white,
                      ),
                    );}
                  else
                    {
                    //  isMarkedFav=blog.markedFav;
                      return IconButton(
                        onPressed: () {
                          if(!isMarkedFav)
                            homeBloc.add(HomeFavoritesBtnClickedEvent(blog: blog));
                        },
                        icon: Icon(
                          isMarkedFav ? Icons.favorite : Icons.favorite_border ,
                          color: isMarkedFav ? Colors.red : Colors.white,
                        ),
                      );
                    }
                  })
              ],
            ),
          ),
         // Text(blog.imageUrl,style: const TextStyle(color: Colors.black),)
        ],
      ),
    ),
  );
}