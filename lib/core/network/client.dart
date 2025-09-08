import 'package:http/http.dart';
import 'package:latom/core/network/response.dart';


class LTHtppClient {

  late Client client;

  LTHtppClient(){
    client = Client();
  }

  Future<LtHttpResponse> get(String endpoint) async {
    Response res = await client.get(Uri.https("api.jikan.moe", endpoint));
    return LtHttpResponse(res);
  }

}