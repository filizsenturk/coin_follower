import 'package:coin_follower/models/usd_model.dart';

class BidModel{
  final UsdModel usdModel;
  BidModel({required this.usdModel});

  factory BidModel.fromJson(Map<String,dynamic> json){
    return BidModel(usdModel:UsdModel.fromJson(json["USD"]));
  }
}