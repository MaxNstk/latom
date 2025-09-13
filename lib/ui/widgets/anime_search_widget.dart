import 'package:flutter/material.dart';
import 'package:latom/core/utils/debounceable.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';


class AnimeSearchWidget extends StatefulWidget {

  final Function(Anime selectedAnime) onSelect; 

  const AnimeSearchWidget({super.key, required this.onSelect});

  @override
  State<AnimeSearchWidget> createState() => _AnimeSearchWidgetState();
}

class _AnimeSearchWidgetState extends State<AnimeSearchWidget> {

  final AnimeService animeService = AnimeService();
  late final Debounceable<Iterable<Anime>?, String> _deboucedSearch; 

  String? _currentQuery;
  Iterable<Anime> _lastOptions = Iterable<Anime>.empty();

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
  void initState() {
    super.initState();
    _deboucedSearch = debounce(_search);
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Anime>(
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final Anime anime = options.elementAt(index);
                return ListTile(
                  title: Text(anime.englishTitle),
                  leading: Image.network(anime.webpImage, width: 40, height: 40, errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported)),
                  onTap: () => onSelected(anime),
                );
              },
            ),
          ),
        );
      },
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
          widget.onSelect(anime);
        });
      },
    );
  }
}