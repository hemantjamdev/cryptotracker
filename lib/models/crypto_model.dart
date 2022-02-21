class CryptoCurrency {
  CryptoCurrency({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
  });

  CryptoCurrency.fromJson(dynamic json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = double.parse((json['current_price'] ?? "").toString());
    marketCap = double.parse((json['market_cap'] ?? "0").toString());
    marketCapRank = json['market_cap_rank'];
    fullyDilutedValuation =
        double.parse((json['fully_diluted_valuation'] ?? "0").toString());
    totalVolume = double.parse((json['total_volume'] ?? "").toString());
    high24h = double.parse((json['high_24h'] ?? "0").toString());
    low24h = double.parse((json['low_24h'] ?? "0").toString());
    priceChange24h = double.parse((json['price_change_24h'] ?? "0").toString());
    priceChangePercentage24h =
        double.parse((json['price_change_percentage_24h'] ?? 0).toString());
    marketCapChange24h =
        double.parse((json['market_cap_change_24h'] ?? 0).toString());
    marketCapChangePercentage24h = double.parse(
        (json['market_cap_change_percentage_24h'] ?? 0).toString());
    circulatingSupply =
        double.parse((json['circulating_supply'] ?? "0").toString());
    totalSupply = double.parse((json['total_supply'] ?? "0").toString());
    maxSupply = double.parse((json['max_supply'] ?? "0").toString());
    ath = double.parse((json['ath'] ?? 0).toString());
    athChangePercentage =
        double.parse((json['ath_change_percentage'] ?? 0).toString());
    athDate = json['ath_date'];
    atl = double.parse((json['atl'] ?? 0).toString());
    atlChangePercentage =
        double.parse((json['atl_change_percentage'] ?? 0).toString());
    atlDate = json['atl_date'];
    roi = json['roi'] != null ? Roi.fromJson(json['roi']) : null;
    lastUpdated = json['last_updated'];
  }
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? fullyDilutedValuation;
  double? totalVolume;
  double? high24h;
  double? low24h;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? marketCapChange24h;
  double? marketCapChangePercentage24h;
  double? circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double? ath;
  double? athChangePercentage;
  String? athDate;
  double? atl;
  double? atlChangePercentage;
  String? atlDate;
  Roi? roi;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symbol'] = symbol;
    map['name'] = name;
    map['image'] = image;
    map['current_price'] = currentPrice;
    map['market_cap'] = marketCap;
    map['market_cap_rank'] = marketCapRank;
    map['fully_diluted_valuation'] = fullyDilutedValuation;
    map['total_volume'] = totalVolume;
    map['high_24h'] = high24h;
    map['low_24h'] = low24h;
    map['price_change_24h'] = priceChange24h;
    map['price_change_percentage_24h'] = priceChangePercentage24h;
    map['market_cap_change_24h'] = marketCapChange24h;
    map['market_cap_change_percentage_24h'] = marketCapChangePercentage24h;
    map['circulating_supply'] = circulatingSupply;
    map['total_supply'] = totalSupply;
    map['max_supply'] = maxSupply;
    map['ath'] = ath;
    map['ath_change_percentage'] = athChangePercentage;
    map['ath_date'] = athDate;
    map['atl'] = atl;
    map['atl_change_percentage'] = atlChangePercentage;
    map['atl_date'] = atlDate;
    if (roi != null) {
      map['roi'] = roi?.toJson();
    }
    map['last_updated'] = lastUpdated;
    return map;
  }
}

class Roi {
  Roi({
    this.times,
    this.currency,
    this.percentage,
  });

  Roi.fromJson(dynamic json) {
    times = json['times'] ?? 0;
    currency = json['currency'];
    percentage = json['percentage'] ?? 0;
  }
  double? times;
  String? currency;
  double? percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['times'] = times;
    map['currency'] = currency;
    map['percentage'] = percentage;
    return map;
  }
}
