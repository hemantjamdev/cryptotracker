import 'package:cryptotracker/models/crypto_model.dart';
import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: const Text("Crypto Tracker",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer<CryptoNotifier>(
          builder: (context, cryptoNotifier, child) {
            if (cryptoNotifier.cryptoMarketList.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: cryptoNotifier.cryptoMarketList.length,
                  itemBuilder: (context, int index) {
                    CryptoCurrency crypto =
                        cryptoNotifier.cryptoMarketList[index];
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(crypto.image!),
                        ),
                        title: Text(crypto.name!+" #${crypto.marketCapRank}"),
                        subtitle: Text(crypto.symbol!.toUpperCase()),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹ " + crypto.currentPrice!.toStringAsFixed(5),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Builder(builder: (context) {
                              double priceChange = crypto.priceChange24h!;
                              double priceChangePer =
                                  crypto.priceChangePercentage24h!;
                              if (priceChange < 0) {
                                return Text(
                                  "${priceChangePer.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                                  style: const TextStyle(color: Colors.red),
                                );
                              } else {
                                return Text(
                                  "${priceChangePer.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                                  style: const TextStyle(color: Colors.green),
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    );
                  });
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
