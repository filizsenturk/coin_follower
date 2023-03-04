import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/screens/coins_details_screen/coins_detail_screen.dart';
import 'package:coin_follower/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CoinListItem extends StatelessWidget {
  final Coin coin;

  const CoinListItem({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 15.h,
      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h, bottom: 1.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(CoinsDetailScreen.routeName,
              arguments: CoinDetailsScreenArguments(coin));
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding:
                EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h, bottom: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    buildIcon(),
                    buildCoinName(),
                  ],
                ),
                buildNumbersColumn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildIcon() {
    return Container(
      padding: EdgeInsets.only(right: 3.w),
      alignment: Alignment.center,
      width: 12.w,
      child: Image.network(coin.imageUrl),
    );
  }

  Column buildCoinName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          coin.name,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
          ),
        ),
        Text(
          coin.symbol.toUpperCase(),
          style: GoogleFonts.montserrat(fontSize: 12.sp),
        )
      ],
    );
  }

  Column buildNumbersColumn() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "${NumberFormat.simpleCurrency().format(coin.priceVsUsd)}",
          style: GoogleFonts.montserrat(fontSize: 14.sp),
        ),
        Text(
          " % " + NumberFormat("####.##").format(coin.priceChange24h),
          style: GoogleFonts.montserrat(
              color: coin.priceChange24h.isNegative
                  ? AppColors.downColor
                  : AppColors.upColor,
              fontSize: 14.sp),
        )
      ],
    );
  }
}
