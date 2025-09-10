
import 'package:flutter/material.dart';
import 'package:latom/ui/pages/anime_screen.dart';
import 'package:latom/ui/pages/search_anime_screen.dart';
import 'package:latom/ui/pages/top_anime_screen.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: "HOME",
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
                    builder: (context) => AnimeSearchForm(),
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
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
