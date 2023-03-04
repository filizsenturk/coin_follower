import 'package:coin_follower/models/chart_data_model.dart';
import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/models/usd_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinChartWidget extends StatefulWidget {
  final List<ChartDataModel> data;
  final Coin coin;
   CoinChartWidget({
    Key? key,
    required this.data,
     required this.coin
  }) : super(key: key);

  @override
  State<CoinChartWidget> createState() => _CoinChartWidgetState();
}

class _CoinChartWidgetState extends State<CoinChartWidget> {
 final List xAxisValues = ["200d" ,"60d", "30d", "14d","7d","24h" ];


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 3.h),
              padding: EdgeInsets.only(left: 3.w,right: 3.w,),
              height: 35.h,
              width: double.infinity,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                borderColor: Colors.grey,
                borderWidth: 1,
                enableAxisAnimation: true,
                plotAreaBorderColor: Colors.lightBlue,
                //plotAreaBackgroundColor: Colors.pink,
                primaryXAxis: CategoryAxis(isVisible: true),
                primaryYAxis: CategoryAxis(isVisible: true),
                legend: Legend(isVisible: false),
              //  title: ChartTitle(text:coin.name.toString()),
                tooltipBehavior: TooltipBehavior(enable: false),
                series: <ChartSeries<ChartDataModel, String>>[
                  LineSeries<ChartDataModel, String>(
                    dataSource: widget.data,
                    xValueMapper: (ChartDataModel sales, i) => xAxisValues[i].toString(),
                    yValueMapper: (ChartDataModel sales, _) => sales.value,
                    color: Colors.amberAccent,
                    animationDelay: 500,
                   markerSettings: MarkerSettings(isVisible: true,width: 2.2.w),
                   // animationDuration: 5000
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}