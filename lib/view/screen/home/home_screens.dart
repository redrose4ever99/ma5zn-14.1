import 'package:com.makzan.eco/provider/search_provider.dart';
import 'package:com.makzan.eco/utill/size.dart';
import 'package:com.makzan.eco/view/screen/category/all_category_screen.dart';
import 'package:com.makzan.eco/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:com.makzan.eco/view/screen/home/widget/shopcat_widget_home_page.dart';
import 'package:com.makzan.eco/view/screen/search/search_by.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/helper/product_type.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/main.dart';
import 'package:com.makzan.eco/provider/auth_provider.dart';
import 'package:com.makzan.eco/provider/banner_provider.dart';
import 'package:com.makzan.eco/provider/brand_provider.dart';
import 'package:com.makzan.eco/provider/cart_provider.dart';
import 'package:com.makzan.eco/provider/category_provider.dart';
import 'package:com.makzan.eco/provider/featured_deal_provider.dart';
import 'package:com.makzan.eco/provider/flash_deal_provider.dart';
import 'package:com.makzan.eco/provider/home_category_product_provider.dart';
import 'package:com.makzan.eco/provider/notification_provider.dart';
import 'package:com.makzan.eco/provider/product_provider.dart';
import 'package:com.makzan.eco/provider/profile_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/provider/top_seller_provider.dart';
import 'package:com.makzan.eco/provider/wishlist_provider.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/title_row.dart';
import 'package:com.makzan.eco/view/screen/brand/all_brand_screen.dart';
import 'package:com.makzan.eco/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:com.makzan.eco/view/screen/home/shimmer/featured_product_shimmer.dart';
import 'package:com.makzan.eco/view/screen/home/widget/announcement.dart';
import 'package:com.makzan.eco/view/screen/home/widget/aster_theme/find_what_you_need_shimmer.dart';
import 'package:com.makzan.eco/view/screen/home/widget/banners_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/brand_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/cart_widget_home_page.dart';
import 'package:com.makzan.eco/view/screen/home/widget/category_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/featured_deal_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/featured_product_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/footer_banner.dart';
import 'package:com.makzan.eco/view/screen/home/widget/home_category_product_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/latest_product_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/products_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/recommended_product_view.dart';
import 'package:com.makzan.eco/view/screen/home/widget/search_widget_home_page.dart';
import 'package:com.makzan.eco/view/screen/home/widget/top_seller_view.dart';
import 'package:com.makzan.eco/view/screen/product/view_all_product_screen.dart';
import 'package:com.makzan.eco/view/screen/search/search_screen.dart';
import 'package:com.makzan.eco/view/screen/shop/all_shop_screen.dart';
import 'package:provider/provider.dart';

import 'shimmer/flash_deal_shimmer.dart';
import 'widget/flash_deals_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {
    await Provider.of<BannerProvider>(Get.context!, listen: false)
        .getBannerList(reload);
    await Provider.of<CategoryProvider>(Get.context!, listen: false)
        .getCategoryList(reload);
    await Provider.of<HomeCategoryProductProvider>(Get.context!, listen: false)
        .getHomeCategoryProductList(reload);
    await Provider.of<TopSellerProvider>(Get.context!, listen: false)
        .getTopSellerList(reload);
    await Provider.of<BrandProvider>(Get.context!, listen: false)
        .getBrandList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getLatestProductList(1, reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getFeaturedProductList('1', reload: reload);
    await Provider.of<FeaturedDealProvider>(Get.context!, listen: false)
        .getFeaturedDealList(reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getLProductList('1', reload: reload);
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getRecommendedProduct();
    await Provider.of<CartProvider>(Get.context!, listen: false)
        .getCartDataAPI(Get.context!);
    await Provider.of<NotificationProvider>(Get.context!, listen: false)
        .getNotificationList(1);
    if (Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn()) {
      await Provider.of<ProfileProvider>(Get.context!, listen: false)
          .getUserInfo(Get.context!);
      await Provider.of<WishListProvider>(Get.context!, listen: false)
          .getWishList();
    }
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";
    Provider.of<FlashDealProvider>(context, listen: false)
        .getMegaDealList(true, true);
    _loadData(false);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    bool isDark = Provider.of<ThemeProvider>(context, listen: false).darkTheme;
    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // const SearchProductWidget();

      // onPressed: () => showModalBottomSheet(
      //     context: context,
      //     isScrollControlled: true,
      //     backgroundColor: Colors.transparent,
      //     builder: (c) => const SearchByScreen()),
      // child: Container(
      //   padding: const EdgeInsets.symmetric(
      //       vertical: Dimensions.paddingSizeExtraSmall,
      //       horizontal: Dimensions.paddingSizeExtraSmall),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(5),
      //       border: Border.all(
      //           color: Theme.of(context).hintColor.withOpacity(.25))),
      //   child: SizedBox(
      //       width: 25,
      //       height: 24,
      //       child: Image.asset(Images.dropdown,
      //           color: Provider.of<ThemeProvider>(context, listen: false)
      //                   .darkTheme
      //               ? Colors.white
      //               : Theme.of(context).primaryColor)),
      // ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadData(true);
            await Provider.of<FlashDealProvider>(Get.context!, listen: false)
                .getMegaDealList(true, false);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Image.asset(
                        isDark ? Images.logoImageDark : Images.logoImage,
                        height: 0.076 * MediaQuery.of(context).size.height),
                  ),
                  expandedHeight: 0.141 * screenHeight,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 8),
                  child: CartWidgetHomePage(),
                )),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: SizedBox(
                    width: screenWidth - 20,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 54,
                                    child: GestureDetector(
                                      onTap: () {
                                        SearchProvider searchProvider =
                                            Provider.of<SearchProvider>(context,
                                                listen: false);
                                        searchProvider.isLoadFilter = false;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const SearchByScreen()));
                                      },
                                      child: const ShopCatWidgetHomePage(),
                                    ))),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    SearchProvider searchProvider =
                                        Provider.of<SearchProvider>(context,
                                            listen: false);
                                    searchProvider.isLoadFilter = false;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SearchScreen()));
                                  },
                                  child: const SearchWidgetHomePage()),
                            ),
                          )
                        ]),
                  )),
                ),
                SliverToBoxAdapter(
                  child: Provider.of<SplashProvider>(context, listen: false)
                              .configModel!
                              .announcement!
                              .status ==
                          '1'
                      ? Consumer<SplashProvider>(
                          builder: (context, announcement, _) {
                            return (announcement.configModel!.announcement!
                                            .announcement !=
                                        null &&
                                    announcement.onOff)
                                ? AnnouncementScreen(
                                    announcement:
                                        announcement.configModel!.announcement)
                                : const SizedBox();
                          },
                        )
                      : const SizedBox(),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(
                            title: getTranslated('all_category', context),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const AllCategoryScreen()))),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      const CategoryView(isHomePage: true),
                      const SizedBox(height: Dimensions.homePagePadding),
                      const BannersView(),

                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      // Flash Deal
                      Consumer<FlashDealProvider>(
                        builder: (context, megaDeal, child) {
                          return megaDeal.flashDeal != null
                              ? megaDeal.flashDealList.isNotEmpty
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              Dimensions.homePagePadding,
                                              Dimensions.paddingSizeSmall,
                                              Dimensions.paddingSizeDefault,
                                              Dimensions
                                                  .paddingSizeExtraExtraSmall),
                                          child: TitleRow(
                                              title: getTranslated(
                                                  'flash_deal', context),
                                              eventDuration:
                                                  megaDeal.flashDeal != null
                                                      ? megaDeal.duration
                                                      : null,
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const FlashDealScreen()));
                                              },
                                              isFlash: true),
                                        ),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeSmall),
                                        Text(
                                            getTranslated(
                                                    'hurry_up_the_offer_is_limited_grab_while_it_lasts',
                                                    context) ??
                                                '',
                                            style: textRegular.copyWith(
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context,
                                                                listen: false)
                                                            .darkTheme
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Theme.of(context)
                                                            .primaryColor)),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeDefault),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .94,
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: Dimensions
                                                        .homePagePadding),
                                                child: FlashDealsView())),
                                      ],
                                    )
                                  : const SizedBox.shrink()
                              : const FlashDealShimmer();
                        },
                      ),

                      // Featured Deal

                      Consumer<FeaturedDealProvider>(
                        builder: (context, featuredDealProvider, child) {
                          return featuredDealProvider.featuredDealProductList !=
                                  null
                              ? featuredDealProvider
                                      .featuredDealProductList!.isNotEmpty
                                  ? Stack(children: [
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 150,
                                          color: Provider.of<ThemeProvider>(
                                                      context,
                                                      listen: false)
                                                  .darkTheme
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.20)
                                              : Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.125)),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              bottom:
                                                  Dimensions.homePagePadding),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: Dimensions
                                                        .paddingSizeDefault),
                                                child: TitleRow(
                                                  title:
                                                      '${getTranslated('featured_deals', context)}',
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              const FeaturedDealScreen())),
                                                ),
                                              ),
                                              const FeaturedDealsView(),
                                            ],
                                          )),
                                    ])
                                  : const SizedBox.shrink()
                              : const FindWhatYouNeedShimmer();
                        },
                      ),

                      //footer banner
                      Consumer<BannerProvider>(
                          builder: (context, footerBannerProvider, child) {
                        return footerBannerProvider.footerBannerList != null &&
                                footerBannerProvider
                                    .footerBannerList!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimensions.homePagePadding,
                                    left: Dimensions.homePagePadding,
                                    right: Dimensions.homePagePadding),
                                child: SingleBannersView(
                                    bannerModel: footerBannerProvider
                                        .footerBannerList?[0]))
                            : const SizedBox();
                      }),

                      // Featured Products
                      Consumer<ProductProvider>(
                          builder: (context, featured, _) {
                        return featured.featuredProductList != null
                            ? featured.featuredProductList!.isNotEmpty
                                ? Stack(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50, bottom: 25),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                10,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    topLeft: Radius.circular(
                                                        Dimensions
                                                            .paddingSizeDefault),
                                                    bottomLeft: Radius.circular(
                                                        Dimensions
                                                            .paddingSizeDefault)),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer),
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeExtraSmall,
                                                vertical: Dimensions
                                                    .paddingSizeExtraSmall),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20,
                                                    left: 50,
                                                    bottom: Dimensions
                                                        .paddingSizeSmall),
                                                child: TitleRow(
                                                    title: getTranslated(
                                                        'featured_products',
                                                        context),
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                AllProductScreen(
                                                                    productType:
                                                                        ProductType
                                                                            .featuredProduct))))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom:
                                                    Dimensions.homePagePadding),
                                            child: FeaturedProductView(
                                              scrollController:
                                                  _scrollController,
                                              isHome: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                            : const FeaturedProductShimmer();
                      }),

                      //top seller
                      singleVendor
                          ? const SizedBox()
                          : TitleRow(
                              title: getTranslated('top_seller', context),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AllTopSellerScreen(
                                            topSeller: null,
                                            title: 'top_seller',
                                          )))),
                      singleVendor
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: Dimensions.paddingSizeSmall),
                      singleVendor
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.only(
                                  bottom: Dimensions.homePagePadding),
                              child: SizedBox(
                                  height: 180,
                                  child: TopSellerView(isHomePage: true))),

                      const Padding(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.homePagePadding),
                          child: RecommendedProductView()),

                      // Latest Products
                      const Padding(
                          padding: EdgeInsets.only(
                              bottom: Dimensions.paddingSizeSmall),
                          child: LatestProductView()),

                      // Brand
                      Provider.of<SplashProvider>(context, listen: false)
                                  .configModel!
                                  .brandSetting ==
                              "1"
                          ? TitleRow(
                              title: getTranslated('brand', context),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AllBrandScreen())))
                          : const SizedBox(),
                      SizedBox(
                          height: Provider.of<SplashProvider>(context,
                                          listen: false)
                                      .configModel!
                                      .brandSetting ==
                                  "1"
                              ? Dimensions.paddingSizeSmall
                              : 0),
                      Provider.of<SplashProvider>(context, listen: false)
                                  .configModel!
                                  .brandSetting ==
                              "1"
                          ? const BrandView(isHomePage: true)
                          : const SizedBox(),

                      //Home category
                      const HomeCategoryProductView(isHomePage: true),
                      const SizedBox(height: Dimensions.homePagePadding),

                      //footer banner
                      Consumer<BannerProvider>(
                          builder: (context, footerBannerProvider, child) {
                        return footerBannerProvider.footerBannerList != null &&
                                footerBannerProvider.footerBannerList!.length >
                                    1
                            ? SingleBannersView(
                                bannerModel:
                                    footerBannerProvider.footerBannerList?[1])
                            : const SizedBox();
                      }),
                      const SizedBox(height: Dimensions.homePagePadding),

                      //Category filter
                      Consumer<ProductProvider>(
                          builder: (ctx, prodProvider, child) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    Dimensions.paddingSizeDefault,
                                    0,
                                    Dimensions.paddingSizeSmall,
                                    0),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(
                                          prodProvider.title == 'xyz'
                                              ? getTranslated(
                                                  'new_arrival', context)!
                                              : prodProvider.title!,
                                          style: titleHeader)),
                                  prodProvider.latestProductList != null
                                      ? PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  value: ProductType.newArrival,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'new_arrival',
                                                      context)!)),
                                              PopupMenuItem(
                                                  value: ProductType.topProduct,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'top_product',
                                                      context)!)),
                                              PopupMenuItem(
                                                  value:
                                                      ProductType.bestSelling,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'best_selling',
                                                      context)!)),
                                              PopupMenuItem(
                                                  value: ProductType
                                                      .discountedProduct,
                                                  textStyle:
                                                      textRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  child: Text(getTranslated(
                                                      'discounted_product',
                                                      context)!)),
                                            ];
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .paddingSizeSmall)),
                                          child: Padding(
                                              padding: const EdgeInsets
                                                      .fromLTRB(
                                                  Dimensions
                                                      .paddingSizeExtraSmall,
                                                  Dimensions.paddingSizeSmall,
                                                  Dimensions
                                                      .paddingSizeExtraSmall,
                                                  Dimensions.paddingSizeSmall),
                                              child: Image.asset(
                                                  Images.dropdown,
                                                  scale: 3)),
                                          onSelected: (dynamic value) {
                                            if (value ==
                                                ProductType.newArrival) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[0]);
                                            } else if (value ==
                                                ProductType.topProduct) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[1]);
                                            } else if (value ==
                                                ProductType.bestSelling) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[2]);
                                            } else if (value ==
                                                ProductType.discountedProduct) {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeTypeOfProduct(
                                                      value, types[3]);
                                            }

                                            ProductView(
                                                isHomePage: false,
                                                productType: value,
                                                scrollController:
                                                    _scrollController);
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .getLatestProductList(1,
                                                    reload: true);
                                          })
                                      : const SizedBox(),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.homePagePadding),
                                child: ProductView(
                                    isHomePage: false,
                                    productType: ProductType.newArrival,
                                    scrollController: _scrollController),
                              ),
                              const SizedBox(
                                  height: Dimensions.homePagePadding),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}
