import 'package:cryptotracker/models/crypto_model.dart';
import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:cryptotracker/widgets/crypto_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CryptoNotifier>(
          builder: (context, cryptoNotifier, child) {
            if (cryptoNotifier.markets.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await cryptoNotifier.fetchData();
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: cryptoNotifier.markets.length,
                    itemBuilder: (context, int index) {
                      CryptoCurrency crypto =
                          cryptoNotifier.markets[index];
                      return CryptoTile(
                        crypto: crypto,
                      );
                    }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
