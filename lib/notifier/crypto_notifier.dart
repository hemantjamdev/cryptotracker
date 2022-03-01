import 'dart:async';
import 'package:cryptotracker/helper/api.dart';
import 'package:cryptotracker/local_storage/local_storage.dart';
import 'package:cryptotracker/models/crypto_model.dart';
import 'package:flutter/foundation.dart';

class CryptoNotifier extends ChangeNotifier {
  CryptoNotifier() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      fetchData();
    });
    notifyListeners();
  }

  static const String api =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=10&page=1&sparkline=false";
  List<CryptoCurrency> markets = [];

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorite();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isFav = true;
      }

      temp.add(newCrypto);
    }

    markets = temp;
    // isLoading = false;
    notifyListeners();
  }

  /// for crypto details page
  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency cryptoCurrency =
        markets.where((element) => element.id == id).toList()[0];
    return cryptoCurrency;
  }

  void addFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFav = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFav = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
