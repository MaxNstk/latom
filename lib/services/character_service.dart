
import 'package:latom/core/network/client.dart';
import 'package:latom/core/network/response.dart';
import 'package:latom/models/character.dart';

class CharacterService {

  late final LTHtppClient client;

  CharacterService(){
    client = LTHtppClient();
  }

  Future<Iterable<Character>> fetchCharacters(String? name) async {
 
    String orderBy = 'favorites';
    String sort = 'desc';

    if (name == null || name.isEmpty){
      return Iterable<Character>.empty();
    }
    final Map<String, dynamic> queryParams = {
      'q':name
      ,'order_by':orderBy
      ,'sort':sort
    };

    LtHttpResponse res = await client.get(
       endpoint:'v4/characters'
      ,queryParams:queryParams
    );
    if (res.statusCode != 200){
      return Iterable<Character>.empty();
    }
    return Character.fromJsonList(res.content['data']);
  } 

}