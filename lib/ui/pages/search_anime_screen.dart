


import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';
import 'package:latom/ui/widgets/anime_search_widget.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class SearchAnimeScreen extends StatefulWidget {
  const SearchAnimeScreen({super.key});

  @override
  State<SearchAnimeScreen> createState() => _SearchAnimeScreenState();
}

class _SearchAnimeScreenState extends State<SearchAnimeScreen> {

  Anime? _selectedAnime;

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'ANIME SEARCH',
      body: Column(
        children: [
          AnimeSearchWidget(
            onSelect: (Anime selectedAnime) => setState(() {
              _selectedAnime = selectedAnime;
            })
          ),
          SizedBox(height: 32,),
          if (_selectedAnime != null)
            AnimeDetailCard(anime: _selectedAnime!)
        ],
      ),
    );
  }
}

