import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';

class AnimeDetailCard extends StatelessWidget {

  final Anime anime;

  const AnimeDetailCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
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
            ,Image.network(anime.getRandomImage(),)
          ],
        ),
      ),
    );
  }
}