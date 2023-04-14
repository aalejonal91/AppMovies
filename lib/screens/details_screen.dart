import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
  final Movie movie= ModalRoute.of(context)!.settings.arguments as Movie;
  //final moviesProvider= Provider.of<MoviesProvider>(context);
  //print (movie.title);

    return  Scaffold(      
      body:
         CustomScrollView(
          //physics: BouncingScrollPhysics(),
          slivers:  [
            _CustomAppBar(movie: movie,),
           SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitle(movie:movie ),
                _Overview(movie:movie),
                _Overview(movie:movie),
                const SizedBox(height: 20,),
                 CastingCards(movie.id),
                
                ]),              
              ),
          ],
         ),   
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar ({ required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return   SliverAppBar(
      backgroundColor: Colors.indigo ,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          //padding:EdgeInsets.symmetric(horizontal: 20),
          child:  Text(movie.title,
            style:const TextStyle( fontSize: 16) ,
            textAlign:TextAlign.center
          ),
        ),
        background: FadeInImage(
          placeholder:const AssetImage('assets/loading.gif'), 
          image:NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover, ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key, required this.movie});
final Movie movie;

  @override
  Widget build(BuildContext context) {
final textTheme= Theme.of(context).textTheme;

    return  Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children:  [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image:NetworkImage(movie.fullPosterImg),
                height: 150,
                
                ),
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Text(movie.title,style: textTheme.headline5,maxLines: 2,overflow:TextOverflow.ellipsis),
                Text(movie.originalTitle,style: textTheme.subtitle1,maxLines: 2,overflow:TextOverflow.ellipsis),
                Row(
                  children:  [
                    const Icon(Icons.star_outline),
                    const SizedBox(width: 5),
                    Text('${movie.voteAverage}', style: textTheme.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({ required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child:  Text(movie.overview,
                   textAlign: TextAlign.justify,
                   style: Theme.of(context).textTheme.subtitle1,
      ),
      
    );
  }
}
