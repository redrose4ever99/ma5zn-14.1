import 'package:flutter/material.dart';
import 'package:com.makzan.eco/data/model/response/top_seller_model.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/basewidget/custom_app_bar.dart';
import 'package:com.makzan.eco/view/screen/home/widget/top_seller_view.dart';

class AllTopSellerScreen extends StatelessWidget {
  final TopSellerModel? topSeller;
  final String title;
  const AllTopSellerScreen({Key? key, required this.topSeller, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: CustomAppBar(title: '${getTranslated(title, context)}',),

      body: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: TopSellerView(isHomePage: false),
      ),
    );
  }
}
