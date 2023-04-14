import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;
  //final List<Movie> titles;

  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {

  final size= MediaQuery.of(context).size;

   if(this.movies==0){
    return Container(
      width:double.infinity ,
      height: size.height*0.5,
      child: const Center(
        child: CircularProgressIndicator(),
      )
    );
   }

    return Container(
      width:double.infinity ,
      height: size.height*0.5,
      child:  Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width* 0.7,
        itemHeight:size.height* 0.4,
        itemBuilder:(_, index) {
          
          final movie= movies[index];
          print(movie.fullPosterImg);

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder:const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  fit:BoxFit.cover
                  ),
              ),
            ),
          );
        },         
      )
    );
  }
}