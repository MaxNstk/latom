

import 'package:latom/core/network/client.dart';
import 'package:latom/core/network/response.dart';
import 'package:latom/models/anime.dart';

class AnimeService {

  late final LTHtppClient client;

  AnimeService(){
    client = LTHtppClient();
  }

  Future<Anime?> getAnimeById(int id) async {
    LtHttpResponse res = await client.get('v4/anime/$id');
    if (res.statusCode != 200){
      return null;
    }
    return Anime.fromJson(res.content["data"]);
  }
}