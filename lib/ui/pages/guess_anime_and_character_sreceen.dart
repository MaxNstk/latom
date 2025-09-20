import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/models/character.dart';
import 'package:latom/services/character_service.dart';
import 'package:latom/ui/widgets/anime_search_widget.dart';
import 'package:latom/ui/widgets/character_search_widget.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class GuessAnimeAndCharacterScreen extends StatefulWidget {
  const GuessAnimeAndCharacterScreen({super.key});

  @override
  State<GuessAnimeAndCharacterScreen> createState() => _GuessAnimeScreenState();
}
class _GuessAnimeScreenState extends State<GuessAnimeAndCharacterScreen> {

  late Future<Character?>? _characterFuture;
  late CharacterService characterService = CharacterService();

  Character? _correctCharacter;

  Character? _selectedCharacter;
  Anime? _selectedAnime;

  void _submit(){

    if (_selectedCharacter == null || _selectedAnime == null){
      SnackBar(content: Text(
        'SHOULD GUESS BOTH'
      ),);
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        _selectedCharacter == _correctCharacter? 'RIGHT CHARACTER' : 'WRONG CHARACTER'
      ),)
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        _correctCharacter.isFrom(_selectedAnime!)? 'RIGHT ANIME' : 'WRONG ANIME'
      ),)
    );
  }

  @override
  void initState() {
    super.initState();
    _characterFuture = characterService.getRandomCharacter(300);
  }
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return LtScaffold(
      title: 'GUESS THE CHARACTER AND ANIME',
      body: LtFutureBuilder(
        nullResponseMsg: 'Not Found',
        future: _characterFuture, 
        builder: (Character? character) {
          if (character == null) {
            return Text("Character not found");
          }
          _correctCharacter = character;
          return Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: SizedBox(
                  height: screenHeight * 0.5,
                  child: Image.network(
                    character.getRandomImage(),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10),
              CharacterSearchWidget(
                onSelect: (Character selectedCharacter) {
                  _selectedCharacter = selectedCharacter;
                },
              ),
              SizedBox(height: 10),
              AnimeSearchWidget(
                onSelect: (Anime selectedAnime){
                  _selectedAnime = selectedAnime;
                }
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                onPressed: _submit,
                tooltip: 'GUESS',
                child: Icon(Icons.send),
              )
            ],
          );
        },
      ),
    );
  }
}
