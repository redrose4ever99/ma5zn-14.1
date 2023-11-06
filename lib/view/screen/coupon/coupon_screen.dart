import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/auth_provider.dart';
import 'package:com.makzan.eco/provider/coupon_provider.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/custom_app_bar.dart';
import 'package:com.makzan.eco/view/basewidget/no_internet_screen.dart';
import 'package:com.makzan.eco/view/basewidget/not_loggedin_widget.dart';
import 'package:com.makzan.eco/view/screen/coupon/widget/coupon_item.dart';
import 'package:com.makzan.eco/view/screen/order/widget/order_shimmer.dart';
import 'package:provider/provider.dart';

class CouponList extends StatefulWidget {
  const CouponList({Key? key}) : super(key: key);

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  void initState() {
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()){
      Provider.of<CouponProvider>(context, listen: false).getCouponList(context, 1);

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupons', context)),
      body: Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?

      Consumer<CouponProvider>(
          builder: (context, couponProvider,_) {
            return couponProvider.couponList != null? couponProvider.couponList!.isNotEmpty?
            Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: couponProvider.couponList!.length,
                  itemBuilder: (context, index){
                    return CouponItem(coupons: couponProvider.couponList![index]);
                  }),
            ) : const NoInternetOrDataScreen(isNoInternet: false,
              icon: Images.noCoupon, message: 'no_coupon_available') : const OrderShimmer();
          }
      ): const NotLoggedInWidget(),
    );
  }
}