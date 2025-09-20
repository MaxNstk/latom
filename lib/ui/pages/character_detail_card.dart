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
      builder: (Character? character) => SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.character.id.toString()),
            SizedBox(height: 10),
            Text(widget.character.name),
            SizedBox(height: 10),
            Image.network(widget.character.getRandomImage()),
            SizedBox(height: 20),
            Text('Animes:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...character!.animeList.map((anime) => 
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: AnimeDetailCard(anime: anime),
              )
            ),
          ],
        ),
      ),
      nullResponseMsg: 'AAAAAAAAAAAA',
    );
  }
}
