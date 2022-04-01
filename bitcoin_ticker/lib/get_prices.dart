
import 'dart:convert';

import 'package:http/http.dart';


class CoinConverter{
  double coinValue = 0.0;
  final String coinName;

  CoinConverter({required this.coinName}){
    convert("USD", coinName);
  }
  convert(String currency, String coinName)async{
    String url = 'https://rest.coinapi.io/v1/exchangerate/$coinName/$currency?apikey=49B49AEA-16E7-4D9F-A541-8116DACDA544';
    Response response = await get(Uri.parse(url));
    final data = await jsonDecode(response.body);
    coinValue= data["rate"];
  }
}


