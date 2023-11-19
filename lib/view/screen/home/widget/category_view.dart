import 'package:com.makzan.eco/utill/size.dart';
import 'package:com.makzan.eco/view/basewidget/spener.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/provider/category_provider.dart';
import 'package:com.makzan.eco/view/screen/home/widget/category_widget.dart';
import 'package:com.makzan.eco/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';


class CategoryView extends StatelessWidget {
  final bool isHomePage;
  const CategoryView({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.isNotEmpty
            ? SizedBox(
                height: height(135),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categoryList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BrandAndCategoryProductScreen(
                                      isBrand: false,
                                      id: categoryProvider
                                          .categoryList[index].id
                                          .toString(),
                                      name: categoryProvider
                                          .categoryList[index].name,
                                    )));
                      },
                      child: CategoryWidget(
                          category: categoryProvider.categoryList[index],
                          index: index,
                          length: categoryProvider.categoryList.length),
                    );
                  },
                ),
              )
            : const MySpener();
      },
    );
  }
}
