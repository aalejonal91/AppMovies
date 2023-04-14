import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {

final List<Movie> movies;
final String? title;
final Function onNextPage;


  const MovieSlider({super.key, required this.movies,  required this.onNextPage,this.title, });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController= new ScrollController();

@override
  void initState() {
    super.initState();
    scrollController.addListener(() { 
      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent-350){
        widget.onNextPage();
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity ,
      height: 260,
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,      
        children:  [
          //condicional if solo debe aparecer cuando le indiquen el titulo porque es opcional
          if(this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title!,style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight:FontWeight.bold ) ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal ,
              itemCount: widget.movies.length,
              itemBuilder:(_, index) => _MoviePoster(movie:widget.movies[index] ),

              ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
final Movie movie;

  const _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 100,
            height: 100 ,        
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children:  [
                GestureDetector(
                  onTap: () =>  Navigator.pushNamed(context, 'details',arguments: movie),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:   FadeInImage(
                      width: 130 ,
                      height:190 ,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/no-image.jpg'), 
                      image: NetworkImage(movie.fullPosterImg),
                      ),
                  ),
                ), 
                const SizedBox(height: 5),
                 Text(
                  movie.title,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis ,
                  textAlign: TextAlign.center,
                  ) 
                
              ]
            ),
          ) ;
  }
}