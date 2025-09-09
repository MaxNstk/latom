import 'package:flutter/material.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';
import 'package:latom/viewmodels/anime_viewmodel.dart';
import 'package:provider/provider.dart';


class AnimeDetailWidget extends StatelessWidget {
  
  final int animeId;

  const AnimeDetailWidget({super.key, required this.animeId});

  @override
  Widget build(BuildContext context) {  
    return ChangeNotifierProvider<AnimeViewModel>(
      create: (_) {
        final viewModel = AnimeViewModel();
        viewModel.getAnimeById(animeId);
        return viewModel;
      },
      child: Consumer<AnimeViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (vm.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error retrieving anime info: ${vm.error}'),
                ],
              )
            );
          }
          return AnimeDetailCard(anime: vm.anime!);
        },
      ),
    );
  }
}