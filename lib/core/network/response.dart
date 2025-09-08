

import 'dart:convert';

import 'package:http/http.dart';

class LtHttpResponse {
  
  late final Response rawResponse;
  late final int statusCode;
  late final String rawContet; 
  late final Map<String, dynamic> content;

  LtHttpResponse(Response response){
    rawResponse = response;
    statusCode = response.statusCode;
    rawContet = response.body;
    content = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  }
}