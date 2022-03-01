
import 'package:cryptotracker/models/crypto_model.dart';
import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:cryptotracker/widgets/crypto_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({ Key? key }) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CryptoNotifier>(
      builder: (context, marketProvider, child) {

        List<CryptoCurrency> favorites = marketProvider.markets.where((element) => element.isFav == true).toList();

        if(favorites.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {

                CryptoCurrency currentCrypto = favorites[index];
                return CryptoTile(crypto: currentCrypto);

              },
            ),
          );
        }
        else {
          return const Center(
            child: Text("No favorites yet", style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),),
          );
        }


      },
    );
    // return Container(
    //   child: Text("Favorites will show up here"),
    // );
  }
}