import 'package:com.makzan.eco/utill/size.dart';
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

class AllCategoryScreenGrid extends StatelessWidget {
  const AllCategoryScreenGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('all_category', context)),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return categoryProvider.categoryList.isNotEmpty
              ? Row(children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 3),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
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
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
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
                          child: CategoryItem(
                            title: category.name,
                            icon: category.icon,
                            isSelected:
                                categoryProvider.categorySelectedIndex == index,
                          ),
                        );
                      },
                    ),
                  ),
                ])
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)));
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
