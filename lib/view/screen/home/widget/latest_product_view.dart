
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/data/model/response/product_model.dart';
import 'package:com.makzan.eco/helper/product_type.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/localization_provider.dart';
import 'package:com.makzan.eco/provider/product_provider.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/basewidget/title_row.dart';
import 'package:com.makzan.eco/view/screen/home/shimmer/latest_product_shimmer.dart';
import 'package:com.makzan.eco/view/screen/home/widget/latest_products_view/latest_product_widget.dart';
import 'package:com.makzan.eco/view/screen/product/view_all_product_screen.dart';
import 'package:provider/provider.dart';


class LatestProductView extends StatelessWidget {
  const LatestProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product>? productList;
        productList = prodProvider.lProductList;

        return productList != null? productList.isNotEmpty ?
          Column(children: [
              TitleRow(title: getTranslated('latest_products', context),
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.latestProduct)))),

              const SizedBox(height: Dimensions.paddingSizeSmall),
              SizedBox(height: 410,
                child: Padding(padding: EdgeInsets.only(left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Dimensions.paddingSizeDefault:0,
                    right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0 : Dimensions.paddingSizeDefault,
                    bottom: Dimensions.paddingSizeDefault),
                  child: Swiper(
                    autoplay: true,
                    layout: SwiperLayout.STACK,

                    itemWidth: MediaQuery.of(context).size.width-50,
                    itemHeight: 400.0,
                    itemBuilder: (BuildContext context,int index){
                      return LatestProductWidget(productModel :productList![index] );
                    },
                    itemCount: productList.length,

                  ),
                ),
              ),
            ],
          ): const SizedBox.shrink() : const LatestProductShimmer();
      },
    );
  }
}

