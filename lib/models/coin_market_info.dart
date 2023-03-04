class CoinMarketInfo{
  final int marketCapRank;
  final double marketCap;
  final double tradingVolume24H;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;

  CoinMarketInfo({required this.marketCapRank,
  required this.marketCap,
  required this.tradingVolume24H,
  required this.circulatingSupply,
  required this.totalSupply,
  required this.maxSupply});
}