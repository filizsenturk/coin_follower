import 'dart:convert';

class FollowedCoins {
  List followedCoinsList;
  FollowedCoins({required this.followedCoinsList});

  Map<String, dynamic> toJson() => {"followed": followedCoinsList};

  static FollowedCoins fromJson(Map<String, dynamic> json) =>
      FollowedCoins(followedCoinsList: json['followed']);
}
