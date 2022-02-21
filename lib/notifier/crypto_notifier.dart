import 'dart:async';
import 'dart:convert';
import 'package:cryptotracker/models/crypto_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CryptoNotifier extends ChangeNotifier {
  CryptoNotifier() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      getMarket();
    });

    notifyListeners();
  }
  static const String api =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  List<CryptoCurrency> cryptoMarketList = [];
  Future getMarket() async {
    Uri path = Uri.parse(api);
    var res = await http.get(path);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      List<dynamic> _market = jsonDecode(res.body);
      List<CryptoCurrency> temp = [];
      for (var market in _market) {
        CryptoCurrency? crypto = CryptoCurrency.fromJson(market);
        temp.add(crypto);
      }
      cryptoMarketList = temp;
      notifyListeners();
    }else {
      print(res.statusCode);
    }
  }
}
