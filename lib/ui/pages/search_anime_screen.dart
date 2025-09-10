


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latom/core/utils/debounceable.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class SearchAnimeScreen extends StatefulWidget {
  const SearchAnimeScreen({super.key});

  @override
  State<SearchAnimeScreen> createState() => _SearchAnimeScreenState();
}

class _SearchAnimeScreenState extends State<SearchAnimeScreen> {

  String? _query;
  Anime? _selectedAnime;

  Iterable<Anime> _lastOptions = Iterable<Anime>.empty();
  
  late final Debounceable<Iterable<Anime>?, String> _deboucedSearch; 

  Future<Iterable<Anime>> _search(String query) async {

    _query = query;
    Iterable<Anime> results = await AnimeService().fetchAnimes(_query);

    if (_query != query){
      return List.empty();
    }
    _query = null;
    return results;
  }

  @override
  void initState() {
    super.initState();
    _deboucedSearch = debounce(_search);
  }


  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'Pesquisa anime',
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Autocomplete<Anime>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              final Iterable<Anime>? options = await _deboucedSearch(textEditingValue.text);
              if (options!.isEmpty){ 
                return _lastOptions;
              }
              _lastOptions = options;
              return options;
            },
            displayStringForOption: (Anime anime) => anime.englishTitle,
            onSelected: (Anime anime) {
              setState(() {
                _selectedAnime = anime;
              });
            },
          ),
          SizedBox(height: 32,),
          if (_selectedAnime != null)
            AnimeDetailCard(anime: _selectedAnime!)
          ],
        ),
      )),
    );
  }
}

