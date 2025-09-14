import 'package:flutter/material.dart';
import 'package:latom/models/character.dart';
import 'package:latom/services/character_service.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';


class CharacterDetailCard extends StatefulWidget {

  final Character character;

  const CharacterDetailCard({super.key, required this.character});

  @override
  State<CharacterDetailCard> createState() => _CharacterDetailCardState();
}

class _CharacterDetailCardState extends State<CharacterDetailCard> {

  final CharacterService characterService = CharacterService();

  Future<Character> getUpdatedCharacter() async {
    await characterService.populateCharacterAnimes(widget.character);
    await characterService.populateCharacterImages(widget.character);
    return widget.character;
  }

  @override
  Widget build(BuildContext context) {
    return LtFutureBuilder(
      future: getUpdatedCharacter(), 
      builder: (Character? character) => Column(
        children: [
          Text(widget.character.id.toString())
          ,SizedBox(height: 10)
          ,Text(widget.character.name)
          ,SizedBox(height: 10)
          ,Image.network(widget.character.getRandomImage())
          ,SizedBox(height: 20)
          ,Text('Animes:', style: TextStyle(fontWeight: FontWeight.bold))
          ,Expanded(
            child: ListView.builder(
              itemCount: character!.animeList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8), 
                  child: AnimeDetailCard(anime: character.animeList[index])
                );
              } 
            ),
          ),
        ],
      ),
      nullResponseMsg: 'AAAAAAAAAAAA'
    );
  }

}

// Text(widget.character.animeList[index].englishTitle),
//Column(
//  children: [
//    //AnimeDetailCard(anime: widget.character.animeList[index]),
//    Text(widget.character.animeList[index].englishTitle),
//    SizedBox(height: 8,)
//  ],
//),
//children: [
//  Text(widget.character.id.toString())
//  ,SizedBox(height: 10)
//  ,Text(widget.character.name)
//  ,SizedBox(height: 10)
//  ,Image.network(widget.character.getRandomImage())
//  ,SizedBox(height: 20)
//  ,Text('Animes:', style: TextStyle(fontWeight: FontWeight.bold))
//  //Expanded(child: ListView(children: widget.character.animeList.map((Anime anime) =>  AnimeDetailCard(anime:anime)).toList(),))
//],