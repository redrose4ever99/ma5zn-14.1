import 'package:com.makzan.eco/utill/size.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/provider/category_provider.dart';
import 'package:com.makzan.eco/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import '../shimmer/category_shimmer.dart';

class AllCategoryView extends StatelessWidget {
  final bool isHomePage;
  const AllCategoryView({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: width(110),
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  padding: EdgeInsets.zero,
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
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          ),
                        ));
                    //   child: CategoryWidget(
                    //       category: categoryProvider.categoryList[index],
                    //       index: index,
                    //       length: categoryProvider.categoryList.length),
                    // );
                  },
                ),
              )
            : const CategoryShimmer();
      },
    );
  }
}
