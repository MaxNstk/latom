

import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';

class GuessAnimeScreen extends StatefulWidget {
  const GuessAnimeScreen({super.key});

  @override
  State<GuessAnimeScreen> createState() => _GuessAnimeScreenState();
}

class _GuessAnimeScreenState extends State<GuessAnimeScreen> {

  AnimeService animeService = AnimeService();

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'GUESS THE ANIME',
      body: LtFutureBuilder(
        nullResponseMsg: 'Not Found',
        future: animeService.getRandomAnimesAndImages(animeCount: 1),
        builder: (Map<Anime, String>? animesData) {
          final animeList = animesData!.entries.toList();
          return ListView.builder(
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              final entry = animeList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(entry.key.englishTitle), // Anime title
                    Image.network(entry.value), // Image URL
                  ],
                ),
              );
            },
          );
        }
      )
    );
  }
}