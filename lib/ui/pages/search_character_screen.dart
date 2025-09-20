import 'package:flutter/material.dart';
import 'package:latom/models/character.dart';
import 'package:latom/ui/pages/character_detail_card.dart';
import 'package:latom/ui/widgets/character_search_widget.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class SearchCharacterScreen extends StatefulWidget {
  const SearchCharacterScreen({super.key});

  @override
  State<SearchCharacterScreen> createState() => _SearchCharacterScreenState();
}

class _SearchCharacterScreenState extends State<SearchCharacterScreen> {

  Character? _selectedCharacter;

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'CHARACTER SEARCH',
      body: Column(
        children: [
          CharacterSearchWidget(
            onSelect: (Character selectedCharacter) => setState(() {
              _selectedCharacter = selectedCharacter;
            })
          ),
          SizedBox(height: 32,),
          if (_selectedCharacter != null)
            Expanded(child: CharacterDetailCard(character: _selectedCharacter!))
        ],
      ),
    );
  }
}

