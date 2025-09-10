import 'package:flutter/material.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';


class GetAnimeByIdScreen extends StatelessWidget {
  
  final int animeId;

  const GetAnimeByIdScreen({super.key, required this.animeId});

  @override
  Widget build(BuildContext context) {
    return LtFutureBuilder(
      builder: (anime) => AnimeDetailCard(anime: anime!),
      future: AnimeService().getAnimeById(animeId)
    );
  }
}