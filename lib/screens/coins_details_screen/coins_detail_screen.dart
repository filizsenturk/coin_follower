import 'package:coin_follower/models/chart_data_model.dart';
import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/widgets/chart_widget.dart';
import 'package:coin_follower/widgets/sliver_appbar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CoinsDetailScreen extends StatelessWidget {
  static const routeName="/CoinsDetailScreen";
  final Coin coin;
  const CoinsDetailScreen({Key? key,required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  var coinPrice = coin.bidModel.usdModel;

    List<ChartDataModel> data = [
      ChartDataModel(coin.percentChange_200d, 4800),
      ChartDataModel(coin.percentChange_60d, 1440),
      ChartDataModel(coin.percentChange_30d, 720),
      ChartDataModel(coin.percentChange_14d, 336),
      ChartDataModel(coin.percentChange_7d, 168),
      ChartDataModel(coin.priceChange24h, 24),
    ];

    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 10.h,
              scrolledUnderElevation: 5.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 20.h,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(coin.name.toString()),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
                delegate: SliverAppBarDelegate(
                  maxHeight:360,
                  child: Container(
                    child: CoinChartWidget(data: data,coin: coin,),
                  ),
                  minHeight:360,
                ))
          ],
        )
      ),
    );
  }
}

class CoinDetailsScreenArguments {
   Coin coin;

  CoinDetailsScreenArguments(this.coin,);
}
