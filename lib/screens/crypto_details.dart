import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptotracker/helper/colors.dart';
import 'package:cryptotracker/models/crypto_model.dart';
import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoDetail extends StatefulWidget {
  final String id;
  final String name;

  const CryptoDetail({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _CryptoDetailState createState() => _CryptoDetailState();
}

class _CryptoDetailState extends State<CryptoDetail> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        Text(detail, style: const TextStyle(fontSize: 17)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Consumer<CryptoNotifier>(
              builder: (context, marketProvider, child) {
                CryptoCurrency currentCrypto =
                    marketProvider.fetchCryptoById(widget.id);

                return RefreshIndicator(
                  onRefresh: () async {
                    marketProvider.fetchCryptoById(widget.id);
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundColor: white,
                          backgroundImage:
                              CachedNetworkImageProvider(currentCrypto.image!),
                        ),
                        title: Text(
                          currentCrypto.name! +
                              " (${currentCrypto.symbol!.toUpperCase()})",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
                          style: const TextStyle(
                              color: deepPurple,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Price Change (24h)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Builder(
                            builder: (context) {
                              double priceChange =
                                  currentCrypto.priceChange24h!;
                              double priceChangePercentage =
                                  currentCrypto.priceChangePercentage24h!;

                              if (priceChange < 0) {
                                // negative
                                return Text(
                                  "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                  style:
                                      const TextStyle(color: red, fontSize: 23),
                                );
                              } else {
                                // positive
                                return Text(
                                  "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                  style: const TextStyle(
                                      color: green, fontSize: 23),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetail(
                              "Market Cap",
                              "₹ " +
                                  currentCrypto.marketCap!.toStringAsFixed(4),
                              CrossAxisAlignment.start),
                          titleAndDetail(
                              "Market Cap Rank",
                              "#" + currentCrypto.marketCapRank.toString(),
                              CrossAxisAlignment.end),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetail(
                              "Low 24h",
                              "₹ " + currentCrypto.low24h!.toStringAsFixed(4),
                              CrossAxisAlignment.start),
                          titleAndDetail(
                              "High 24h",
                              "₹ " + currentCrypto.high24h!.toStringAsFixed(4),
                              CrossAxisAlignment.end),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetail(
                              "Circulating Supply",
                              currentCrypto.circulatingSupply!
                                  .toInt()
                                  .toString(),
                              CrossAxisAlignment.start),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetail(
                              "All Time Low",
                              currentCrypto.atl!.toStringAsFixed(4),
                              CrossAxisAlignment.start),
                          titleAndDetail(
                              "All Time High",
                              currentCrypto.ath!.toStringAsFixed(4),
                              CrossAxisAlignment.start),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
