import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:provider/provider.dart';

class LocationWidgetHomePage extends StatelessWidget {
  const LocationWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.homePagePadding,
            vertical: Dimensions.paddingSizeSmall),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.only(
              left: Dimensions.homePagePadding,
              right: Dimensions.paddingSizeExtraSmall),
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: Provider.of<ThemeProvider>(context).darkTheme
                ? null
                : [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 0))
                  ],
            borderRadius:
                BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(getTranslated('delivery_to', context) ?? '',
                style:
                    textRegular.copyWith(color: Theme.of(context).hintColor)),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.paddingSizeExtraSmall))),
              child: Icon(Icons.location_pin,
                  color: Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme
                      ? Colors.white
                      : Theme.of(context).cardColor,
                  size: Dimensions.iconSizeSmall),
            ),
          ]),
        ),
      ),
    );
  }
}