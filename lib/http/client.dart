import 'package:http/http.dart' as http;
import 'package:latom/http/response.dart';


class LTHtppClient {

  late http.Client client;

  LTHtppClient(){
    client = http.Client();
  }

  LtHttpResponse get(String endpoint){
    return LtHttpResponse();
  }

}