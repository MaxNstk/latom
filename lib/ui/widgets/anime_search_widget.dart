import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/debouced_autocomplete.dart';


class AnimeSearchWidget extends StatefulWidget {

  final Function(Anime selectedAnime) onSelect; 

  const AnimeSearchWidget({super.key, required this.onSelect});

  @override
  State<AnimeSearchWidget> createState() => _AnimeSearchWidgetState();
}

class _AnimeSearchWidgetState extends State<AnimeSearchWidget> {

  final AnimeService animeService = AnimeService();
  String? _currentQuery;

  Future<Iterable<Anime>> _search(String query) async {
    _currentQuery = query;
    Iterable<Anime> results = await animeService.fetchAnimes(_currentQuery);

    if (_currentQuery != query){
      return List.empty();
    }
    _currentQuery = null;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return DebouncedAutocomplete<Anime>(
      onSelect: (Anime anime) {
        setState(() {
          widget.onSelect(anime);
        });
      }, 
      searchFunction: _search, 
      getDisplayStringForOption: (Anime opt) => opt.englishTitle
    );
  }
}