import 'package:flutter/material.dart';

import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/flash_deal_provider.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/basewidget/custom_app_bar.dart';
import 'package:com.makzan.eco/view/basewidget/title_row.dart';
import 'package:com.makzan.eco/view/screen/home/widget/flash_deals_view.dart';
import 'package:provider/provider.dart';

class FlashDealScreen extends StatefulWidget {
  const FlashDealScreen({Key? key}) : super(key: key);


  @override
  State<FlashDealScreen> createState() => _FlashDealScreenState();
}

class _FlashDealScreenState extends State<FlashDealScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: getTranslated('flash_deal', context)),

        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: TitleRow(title: getTranslated('flash_deal', context), eventDuration: Provider.of<FlashDealProvider>(context).duration, isDetailsPage: true, ),),

        Expanded(child: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<FlashDealProvider>(context, listen: false).getMegaDealList(true, false);
          },
          child: const Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: FlashDealsView(isHomeScreen: false),
          ),
        )),

      ]),
    );
  }
}
