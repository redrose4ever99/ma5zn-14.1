import 'package:com.makzan.eco/utill/size.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/helper/price_converter.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/product_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/custom_image.dart';
import 'package:com.makzan.eco/view/screen/home/shimmer/recommended_product_shimmer.dart';
import 'package:com.makzan.eco/view/screen/product/product_details_screen.dart';
import 'package:com.makzan.eco/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';

class RecommendedProductView extends StatelessWidget {
  final bool fromAsterTheme;
  const RecommendedProductView({Key? key, this.fromAsterTheme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: Dimensions.paddingSizeSmall,
          bottom: Dimensions.paddingSizeDefault),
      color: Theme.of(context).primaryColor.withOpacity(.125),
      child: Column(
        children: [
          Consumer<ProductProvider>(
            builder: (context, recommended, child) {
              String? ratting = recommended.recommendedProduct != null &&
                      recommended.recommendedProduct!.rating != null &&
                      recommended.recommendedProduct!.rating!.isNotEmpty
                  ? recommended.recommendedProduct!.rating![0].average
                  : "0";

              return recommended.recommendedProduct != null
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 1000),
                              pageBuilder: (context, anim1, anim2) =>
                                  ProductDetails(
                                productId: recommended.recommendedProduct!.id,
                                slug: recommended.recommendedProduct!.slug,
                              ),
                            ));
                      },
                      child: Stack(
                        children: [
                          Positioned(
                              top: -10,
                              left: MediaQuery.of(context).size.width * 0.35,
                              child: Image.asset(
                                Images.dealOfTheDay,
                                width: 150,
                                height: 150,
                                opacity: const AlwaysStoppedAnimation(0.25),
                              )),
                          Column(
                            children: [
                              fromAsterTheme
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeSmall),
                                          child: Text(
                                            getTranslated(
                                                    'dont_miss_the_chance',
                                                    context) ??
                                                '',
                                            style: textBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context,
                                                                listen: false)
                                                            .darkTheme
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Theme.of(context)
                                                            .primaryColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom:
                                                  Dimensions.paddingSizeSmall),
                                          child: Text(
                                            getTranslated('lets_shopping_today',
                                                    context) ??
                                                '',
                                            style: textBold.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraLarge,
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context,
                                                                listen: false)
                                                            .darkTheme
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Theme.of(context)
                                                            .primaryColor),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: Dimensions.paddingSizeDefault,
                                          top:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Text(
                                        getTranslated(
                                                'deal_of_the_day', context) ??
                                            '',
                                        style: textBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeExtraLarge,
                                            color: Provider.of<ThemeProvider>(
                                                        context,
                                                        listen: false)
                                                    .darkTheme
                                                ? Theme.of(context).hintColor
                                                : Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.homePagePadding),
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeDefault),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.paddingSizeSmall)),
                                          color: Provider.of<ThemeProvider>(
                                                      context,
                                                      listen: false)
                                                  .darkTheme
                                              ? Theme.of(context).highlightColor
                                              : Theme.of(context)
                                                  .highlightColor,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.40),
                                              width: 1)),
                                      child: Row(
                                        children: [
                                          recommended.recommendedProduct !=
                                                      null &&
                                                  recommended
                                                          .recommendedProduct!
                                                          .thumbnail !=
                                                      null
                                              ? Container(
                                                  width: width(135),
                                                  height: (recommended
                                                                  .recommendedProduct!
                                                                  .currentStock! <
                                                              recommended
                                                                  .recommendedProduct!
                                                                  .minimumOrderQuantity! &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .productType ==
                                                              'physical')
                                                      ? 170
                                                      : 150,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(.20),
                                                          width: .5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5)),
                                                      child: CustomImage(
                                                          image:
                                                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${recommended.recommendedProduct!.thumbnail}')),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraExtraSmall),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (recommended
                                                          .recommendedProduct!
                                                          .currentStock! <
                                                      recommended
                                                          .recommendedProduct!
                                                          .minimumOrderQuantity! &&
                                                  recommended
                                                          .recommendedProduct!
                                                          .productType ==
                                                      'physical')
                                                Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: Dimensions
                                                            .paddingSizeExtraSmall),
                                                    child: Text(getTranslated('out_of_stock', context) ?? '',
                                                        style: textRegular.copyWith(
                                                            color:
                                                                const Color(0xFFF36A6A)))),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.star,
                                                      color:
                                                          Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .darkTheme
                                                              ? Colors.white
                                                              : Colors.orange,
                                                      size: 15),
                                                  Text(
                                                      double.parse(ratting!)
                                                          .toStringAsFixed(1),
                                                      style: titilliumBold.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault)),
                                                  Text(
                                                      '(${ratting.toString()})',
                                                      style: textRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault,
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeExtraExtraSmall),
                                                  recommended
                                                                  .recommendedProduct !=
                                                              null &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .discount !=
                                                              null &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .discount! >
                                                              0
                                                      ? Text(
                                                          PriceConverter.convertPrice(
                                                              context,
                                                              recommended
                                                                  .recommendedProduct!
                                                                  .unitPrice),
                                                          style: textRegular
                                                              .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeExtraExtraSmall,
                                                      width: Dimensions
                                                          .paddingSizeExtraSmall),
                                                  recommended.recommendedProduct !=
                                                              null &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .unitPrice !=
                                                              null
                                                      ? Text(
                                                          PriceConverter.convertPrice(
                                                              context,
                                                              recommended
                                                                  .recommendedProduct!.unitPrice,
                                                              discountType: recommended
                                                                  .recommendedProduct!
                                                                  .discountType,
                                                              discount: recommended
                                                                  .recommendedProduct!
                                                                  .discount),
                                                          style:
                                                              textBold.copyWith(
                                                            color: ColorResources
                                                                .getPrimary(
                                                                    context),
                                                            fontSize: Dimensions
                                                                .fontSizeLarge,
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                              const SizedBox(
                                                height:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Text(
                                                      recommended
                                                              .recommendedProduct!
                                                              .name ??
                                                          '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: titilliumRegular
                                                          .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeLarge))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: Dimensions
                                                        .paddingSizeDefault),
                                                child: Container(
                                                  width: 110,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius
                                                            .all(
                                                        Radius.circular(Dimensions
                                                            .paddingSizeOverLarge)),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    getTranslated(
                                                        'buy_now', context)!,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right: 20,
                                      child: FavouriteButton(
                                        backgroundColor:
                                            ColorResources.getImageBg(context),
                                        productId:
                                            recommended.recommendedProduct?.id,
                                      )),
                                  recommended.recommendedProduct != null &&
                                          recommended.recommendedProduct!
                                                  .discount !=
                                              null &&
                                          recommended.recommendedProduct!
                                                  .discount! >
                                              0
                                      ? Positioned(
                                          top: 25,
                                          left: 32,
                                          child: Container(
                                              height: 20,
                                              padding: const EdgeInsets
                                                      .symmetric(
                                                  horizontal: Dimensions
                                                      .paddingSizeExtraSmall),
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.getPrimary(
                                                        context),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5)),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                PriceConverter
                                                    .percentageCalculation(
                                                        context,
                                                        recommended
                                                            .recommendedProduct!
                                                            .unitPrice,
                                                        recommended
                                                            .recommendedProduct!
                                                            .discount,
                                                        recommended
                                                            .recommendedProduct!
                                                            .discountType),
                                                style: textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall),
                                              ))))
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const RecommendedProductShimmer();
            },
          ),
        ],
      ),
    );
  }
}
