import 'dart:async';
import 'package:cryptotracker/helper/api.dart';
import 'package:cryptotracker/local_storage/local_storage.dart';
import 'package:cryptotracker/models/crypto_model.dart';
import 'package:flutter/foundation.dart';

class CryptoNotifier extends ChangeNotifier {
  int perPage = 10;
  CryptoNotifier() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      fetchData();
    });
    notifyListeners();
  }

  List<CryptoCurrency> markets = [];

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets(perPage);
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
