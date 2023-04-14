

import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider= Provider.of<MoviesProvider>(context);
    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Peliculas En Cine'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate() )
            ), 
          ],  
         ),
      body:  SingleChildScrollView(        
        child: Column(
          children:  [
            //Tarjetas Principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title:'Populares',
              onNextPage:()=> moviesProvider.getPopularMovies(),
             
            ),
            
            
          ],
        ),
      )
    );

  }
}