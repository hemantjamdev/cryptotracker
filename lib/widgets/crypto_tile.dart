import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptotracker/helper/colors.dart';
import 'package:cryptotracker/models/crypto_model.dart';
import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:cryptotracker/screens/crypto_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoTile extends StatelessWidget {
  final CryptoCurrency crypto;
  const CryptoTile({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: black,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CryptoDetail(
                id: crypto.id!,
                name: crypto.symbol!.toUpperCase(),
              ),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: CachedNetworkImageProvider(crypto.image!),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                crypto.name! + " #${crypto.marketCapRank}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Consumer<CryptoNotifier>(builder: (context, cryptoNotifier, child) {
              return (crypto.isFav == false)
                  ? GestureDetector(
                      onTap: () {
                        cryptoNotifier.addFavorite(crypto);
                      },
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 18,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        cryptoNotifier.removeFavorite(crypto);
                      },
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        size: 18,
                        color: red,
                      ),
                    );
            })
          ],
        ),
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
              double priceChangePer = crypto.priceChangePercentage24h!;
              if (priceChange < 0) {
                return Text(
                  "${priceChangePer.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                  style: const TextStyle(color: red),
                );
              } else {
                return Text(
                  "+${priceChangePer.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(2)})",
                  style: const TextStyle(color: green),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
