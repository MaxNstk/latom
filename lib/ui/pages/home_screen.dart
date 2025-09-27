import 'package:flutter/material.dart';
import 'package:latom/ui/pages/anime_by_id_screen.dart';
import 'package:latom/ui/pages/guess_anime_and_character_sreceen.dart';
import 'package:latom/ui/pages/guess_anime_screen.dart';
import 'package:latom/ui/pages/preferences_screen.dart';
import 'package:latom/ui/pages/search_anime_screen.dart';
import 'package:latom/ui/pages/search_character_screen.dart';
import 'package:latom/ui/pages/top_anime_screen.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: widget.title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('FIND ANIME BY ID'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => AnimeByIdScreen(),
                  )
                );
              }
            ),
            ElevatedButton(
              child: const Text('FIND ANIME BY NAME'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => SearchAnimeScreen(),
                  )
                );
              }
            ),
            ElevatedButton(
              child: const Text('LIST TOP ANIMES'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => TopAnimeScreen(),
                  )
                );
              }
            ),
            ElevatedButton(
              child: const Text('GUESS THE ANIME'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => GuessAnimeScreen(),
                  )
                );
              }
            ),
            SizedBox(height: 32,),
            ElevatedButton(
              child: const Text('FIND CHARACTER BY NAME'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => SearchCharacterScreen(),
                  )
                );
              }
            ),
            ElevatedButton(
              child: const Text('GUESS ANIME AND CHARACTER'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => GuessAnimeAndCharacterScreen(),
                  )
                );
              }
            ),
            SizedBox(height: 32,),
            ElevatedButton(
              child: const Text('PREFERENCES'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => PreferencesScreen(),
                  )
                );
              }
            ),
          ],
        ),
      )
    );
  }
}
