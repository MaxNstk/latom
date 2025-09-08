import 'package:flutter/foundation.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';

class AnimeViewModel extends ChangeNotifier {
  
  late final AnimeService animeService;

  Anime? anime;
  bool isLoading = false;
  String? error;

  AnimeViewModel(){
    animeService = AnimeService();
  }

  Future<void> getAnimeById(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      
      anime = await animeService.getAnimeById(id);
      if (anime == null){
        error = 'Anime not available';
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}