import 'package:com.makzan.eco/utill/size.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/data/model/response/category.dart';
import 'package:com.makzan.eco/provider/localization_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/basewidget/custom_image.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final int index;
  final int length;
  const CategoryWidget(
      {Key? key,
      required this.category,
      required this.index,
      required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Provider.of<LocalizationProvider>(context, listen: false).isLtr
              ? Dimensions.homePagePadding
              : 0,
          right: index + 1 == length
              ? Dimensions.paddingSizeDefault
              : Provider.of<LocalizationProvider>(context, listen: false).isLtr
                  ? 0
                  : Dimensions.homePagePadding),
      child: Column(children: [
        Container(
          height: height(70),
          width: height(70),
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.125),
                width: .25),
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor.withOpacity(.125),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CustomImage(
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.categoryImageUrl}'
                    '/${category.icon}',
              )),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Center(
          child: SizedBox(
            width: width(65),
            child: Wrap(
              children: [
                Text(category.name!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: ColorResources.getTextTitle(context))),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
