import 'package:http/http.dart';
import 'package:latom/core/network/response.dart';


class LTHtppClient {

  // https://docs.api.jikan.moe/#tag/anime

  Client client = Client();

  Future<LtHttpResponse> get({required String endpoint, Map<String, dynamic>? queryParams}) async {
    Response res = await client.get(Uri.https("api.jikan.moe", endpoint, queryParams));
    return LtHttpResponse(res);
  }

}