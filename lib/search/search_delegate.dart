


import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate  {
@override
  
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () { query='';},)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () { close(context, null);}
      );
    }
  

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _EmptyContainer() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.movie_creation_outlined,size: 120),
            Icon(Icons.close_rounded,size: 80,),
          ]
    );        
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    
    if(query.isEmpty) {
      return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.movie_creation_outlined,size: 120),
            Icon(Icons.close_rounded,size: 80,),
          ],
        ),         
      );      
    }
    
    return 
    FutureBuilder(
      future: moviesProvider.searchMovie(query),
      
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot) {



        if(!snapshot.hasData) return _EmptyContainer();
        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( _ , int index) => _MovieItem(movies[index])
        );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {
final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
              leading: FadeInImage(
                placeholder:const AssetImage('assets/no-image.jpg'),                
                image: NetworkImage(movie.fullPosterImg),
                width: 50,
                fit: BoxFit.contain,
                ),
              title: Text(movie.title),  
              subtitle: Text(movie.originalTitle),
              onTap:  () => Navigator.pushNamed(context, 'details',arguments: movie),
    ); 
  }
}