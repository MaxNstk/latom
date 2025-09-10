import 'package:flutter/material.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';


class GetAnimeByIdScreen extends StatelessWidget {
  
  final int animeId;

  const GetAnimeByIdScreen({super.key, required this.animeId});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: AnimeService().getAnimeById(animeId), 
      builder: (context, snapshot){
        List<Widget> children;
        if (snapshot.hasData){
          children = snapshot.data == null ?
            [Container(child: const Text("Not found"))] :
            [AnimeDetailCard(anime: snapshot.data!)];
        }
        else if (snapshot.hasError){
          children = [
            const Icon(Icons.error_outline, color: Colors.red, size: 30),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Error retrieving anime info: ${snapshot.error}')
            )
          ];
        }else{
          children = [
            SizedBox(width:30, height: 30, child: CircularProgressIndicator())
          , Padding(padding: EdgeInsets.only(top: 12), child: Text("Loading..."),)
          ];          
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          )
        );
      }
    );
  }
}
