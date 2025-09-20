

import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/anime_search_widget.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';

class GuessAnimeScreen extends StatefulWidget {
  const GuessAnimeScreen({super.key});

  @override
  State<GuessAnimeScreen> createState() => _GuessAnimeScreenState();
}

class _GuessAnimeScreenState extends State<GuessAnimeScreen> {

  AnimeService animeService = AnimeService();

  void _onSelect(Anime listedAnime, Anime selectedAnime){
    if (selectedAnime.id == listedAnime.id){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('YOU GUESSED IT!!')),
      );
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('YOUR ARE WRONG :(')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'GUESS THE ANIME',
      body: LtFutureBuilder(
        nullResponseMsg: 'Not Found',
        future: animeService.getRandomAnimes(animeCount: 3),
        builder: (List<Anime>? animeList) {
          return ListView.builder(
            itemCount: animeList!.length,
            itemBuilder: (context, index) {
              final anime = animeList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AnimeSearchWidget(onSelect: (Anime selectedAnime) => _onSelect(anime, selectedAnime)),
                    Text(anime.englishTitle),
                    Image.network(anime.getRandomImage()),
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