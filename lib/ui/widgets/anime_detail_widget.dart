import 'package:flutter/material.dart';
import 'package:latom/viewmodels/anime_viewmodel.dart';
import 'package:provider/provider.dart';


class AnimeDetailWidget extends StatelessWidget {
  
  final int animeId;

  const AnimeDetailWidget({super.key, required this.animeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnimeViewModel>(
      create: (_) {
        final viewModel = AnimeViewModel();
        viewModel.getAnimeById(animeId);
        return viewModel;
      },
      child: Consumer<AnimeViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (vm.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error retrieving anime info: ${vm.error}'),
                ],
              )
            );
          }
    
          final anime = vm.anime!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('id: ${anime.id}')
                ,SizedBox(height: 10)
                ,Text('englishTitle: ${anime.englishTitle}')
                ,SizedBox(height: 10)
                ,Text('japaneseTitle: ${anime.japaneseTitle}')
                ,SizedBox(height: 10)
                ,Text('score: ${anime.score}')
                ,SizedBox(height: 10)
                ,Image.network(anime.webpImage)
              ],
            ),
          );
        },
      ),
    );
  }
}