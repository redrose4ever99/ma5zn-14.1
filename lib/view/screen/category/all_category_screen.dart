import 'package:com.makzan.eco/utill/size.dart';
import 'package:com.makzan.eco/view/basewidget/spener.dart';
import 'package:com.makzan.eco/view/screen/home/widget/banners_view.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/data/model/response/category.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/category_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/custom_app_bar.dart';
import 'package:com.makzan.eco/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('all_category', context)),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return categoryProvider.categoryList.isNotEmpty
              ? Row(children: [
                  Container(
                    width: width(110),
                    margin: const EdgeInsets.only(top: 3),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[
                                Provider.of<ThemeProvider>(context).darkTheme
                                    ? 700
                                    : 200]!,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ],
                    ),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryProvider.categoryList.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        Category category =
                            categoryProvider.categoryList[index];
                        return InkWell(
                          onTap: () => Provider.of<CategoryProvider>(context,
                                  listen: false)
                              .changeSelectedIndex(index),
                          child: Container(
                            color:
                                categoryProvider.categorySelectedIndex == index
                                    ? Theme.of(context).cardColor
                                    : Theme.of(context).scaffoldBackgroundColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                category.name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color:
                                      categoryProvider.categorySelectedIndex ==
                                              index
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                          ),
                          // CategoryItem(
                          //   title: category.name,
                          //   icon: category.icon,
                          //   isSelected:
                          //       categoryProvider.categorySelectedIndex == index,
                          // ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    itemCount: categoryProvider
                            .categoryList[
                                categoryProvider.categorySelectedIndex!]
                            .subCategories!
                            .length +
                        1,
                    itemBuilder: (context, index) {
                      late SubCategory subCategory;
                      if (index != 0) {
                        subCategory = categoryProvider
                            .categoryList[
                                categoryProvider.categorySelectedIndex!]
                            .subCategories![index - 1];
                      }
                      if (index == 0) {
                        return Column(
                          children: [
                            const BannersView(),
                            Ink(
                              color: Theme.of(context).highlightColor,
                              child: ListTile(
                                title: Text(
                                    getTranslated('all_products', context)!,
                                    style: titilliumSemiBold,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                trailing: const Icon(Icons.navigate_next),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              BrandAndCategoryProductScreen(
                                                isBrand: false,
                                                id: categoryProvider
                                                    .categoryList[categoryProvider
                                                        .categorySelectedIndex!]
                                                    .id
                                                    .toString(),
                                                name: categoryProvider
                                                    .categoryList[categoryProvider
                                                        .categorySelectedIndex!]
                                                    .name,
                                              )));
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (subCategory.subSubCategories!.isNotEmpty) {
                        return Ink(
                          color: Theme.of(context).highlightColor,
                          child: Theme(
                            data: Provider.of<ThemeProvider>(context).darkTheme
                                ? ThemeData.dark()
                                : ThemeData.light(),
                            child: ExpansionTile(
                              key: Key(
                                  '${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
                              title: Text(subCategory.name!,
                                  style: titilliumSemiBold.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              children:
                                  _getSubSubCategories(context, subCategory),
                            ),
                          ),
                        );
                      } else {
                        return Ink(
                          color: Theme.of(context).highlightColor,
                          child: ListTile(
                            title: Text(subCategory.name!,
                                style: titilliumSemiBold,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            trailing: Icon(Icons.navigate_next,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          BrandAndCategoryProductScreen(
                                            isBrand: false,
                                            id: subCategory.id.toString(),
                                            name: subCategory.name,
                                          )));
                            },
                          ),
                        );
                      }
                    },
                  )),
                ])
              : const MySpener();
        },
      ),
    );
  }

  List<Widget> _getSubSubCategories(
      BuildContext context, SubCategory subCategory) {
    List<Widget> subSubCategories = [];
    subSubCategories.add(Container(
      color: ColorResources.getIconBg(context),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall),
      child: ListTile(
        title: Row(
          children: [
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                  color: ColorResources.getPrimary(context),
                  shape: BoxShape.circle),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Flexible(
                child: Text(
              getTranslated('all_products', context)!,
              style: titilliumSemiBold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: subCategory.id.toString(),
                        name: subCategory.name,
                      )));
        },
      ),
    ));
    for (int index = 0; index < subCategory.subSubCategories!.length; index++) {
      subSubCategories.add(Container(
        color: ColorResources.getIconBg(context),
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall),
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                    color: ColorResources.getPrimary(context),
                    shape: BoxShape.circle),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Flexible(
                  child: Text(
                subCategory.subSubCategories![index].name!,
                style: titilliumSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BrandAndCategoryProductScreen(
                          isBrand: false,
                          id: subCategory.subSubCategories![index].id
                              .toString(),
                          name: subCategory.subSubCategories![index].name,
                        )));
          },
        ),
      ));
    }
    return subSubCategories;
  }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  const CategoryItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: width(100),
        height: width(100),
        margin: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected ? ColorResources.getPrimary(context) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: isSelected
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).hintColor),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        fit: BoxFit.cover,
                        image:
                            '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.categoryImageUrl}/$icon',
                        imageErrorBuilder: (c, o, s) =>
                            Image.asset(Images.placeholder, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Text(title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: isSelected
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).hintColor,
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
