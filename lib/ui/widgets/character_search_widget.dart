import 'package:flutter/material.dart';
import 'package:latom/models/character.dart';
import 'package:latom/services/character_service.dart';
import 'package:latom/ui/widgets/debouced_autocomplete.dart';


class CharacterSearchWidget extends StatefulWidget {

  final Function(Character selectedCharacter) onSelect; 

  const CharacterSearchWidget({super.key, required this.onSelect});

  @override
  State<CharacterSearchWidget> createState() => _CharacterSearchWidgetState();
}

class _CharacterSearchWidgetState extends State<CharacterSearchWidget> {

  final CharacterService characterService = CharacterService();
  String? _currentQuery;

  Future<Iterable<Character>> _search(String query) async {
    _currentQuery = query;
    Iterable<Character> results = await characterService.fetchCharacters(_currentQuery);

    if (_currentQuery != query){
      return List.empty();
    }
    _currentQuery = null;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return DebouncedAutocomplete<Character>(
      onSelect: widget.onSelect,
      searchFunction: _search, 
      getDisplayStringForOption: (Character opt) => opt.name
    );
  }
}