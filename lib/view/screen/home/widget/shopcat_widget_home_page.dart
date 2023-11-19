import 'package:com.makzan.eco/utill/images.dart';

import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';

import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';

class ShopCatWidgetHomePage extends StatelessWidget {
  const ShopCatWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.homePagePadding),
      child: Container(
        padding: const EdgeInsets.only(
            left: Dimensions.homePagePadding,
            right: Dimensions.homePagePadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                Images.dropdn,
                color: Theme.of(context).primaryColor,
                width: 13.14,
                height: 8.58,
              ),
            ),
          ),
          Text(getTranslated('shop_by_category', context) ?? '',
              style: textRegular.copyWith(
                  color: Theme.of(context).hintColor, fontSize: 12)),
        ]),
      ),
    );
  }
}// Text(getTranslated('shop_by_category', context) ?? '',



