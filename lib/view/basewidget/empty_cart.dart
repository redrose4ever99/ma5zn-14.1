import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/custom_button.dart';
import 'package:com.makzan.eco/view/screen/dashboard/dashboard_screen.dart';
import 'package:com.makzan.eco/view/screen/home/widget/latest_product_view.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      Center(
        child: Image.asset(Images.emptyCart, height: 80, width: 75),
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Text(getTranslated('no_data_found', context) ?? '',
          textAlign: TextAlign.center, style: textRegular.copyWith()),
      const SizedBox(height: 20),
      SizedBox(
        width: 160,
        child: CustomButton(
            backgroundColor: Colors.transparent,
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashBoardScreen()),
                (route) => false),
            isBorder: true,
            textColor: Theme.of(context).primaryColor,
            buttonText: '${getTranslated('continue_shopping', context)}'),
      ),
      const SizedBox(
        height: 20,
      ),

      // Latest Products
      const Padding(
          padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          child: LatestProductView()),
    ]);
  }
}
