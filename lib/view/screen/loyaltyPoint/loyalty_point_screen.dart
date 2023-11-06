import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/auth_provider.dart';
import 'package:com.makzan.eco/provider/profile_provider.dart';
import 'package:com.makzan.eco/provider/wallet_transaction_provider.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/custom_button.dart';
import 'package:com.makzan.eco/view/basewidget/not_loggedin_widget.dart';
import 'package:com.makzan.eco/view/screen/home/home_screens.dart';
import 'package:com.makzan.eco/view/screen/loyaltyPoint/widget/loyalty_point_converter_dialogue.dart';
import 'package:com.makzan.eco/view/screen/loyaltyPoint/widget/loyalty_point_list.dart';
import 'package:com.makzan.eco/view/screen/loyaltyPoint/widget/loyalty_point_top_card.dart';
import 'package:provider/provider.dart';


class LoyaltyPointScreen extends StatefulWidget {
  const LoyaltyPointScreen({Key? key}) : super(key: key);
  @override
  State<LoyaltyPointScreen> createState() => _LoyaltyPointScreenState();
}

class _LoyaltyPointScreenState extends State<LoyaltyPointScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    bool isFirstTime = true;
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(isFirstTime) {
      if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
        Provider.of<WalletTransactionProvider>(context, listen: false).getLoyaltyPointList(context,1);
      }
      isFirstTime = false;
    }

    return Scaffold(
      body: RefreshIndicator(
        color: Theme.of(context).cardColor,
        backgroundColor: Theme.of(context).primaryColor,
        onRefresh: () async {
          Provider.of<WalletTransactionProvider>(context, listen: false).getLoyaltyPointList(context,1);
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
               SliverAppBar(
                toolbarHeight: 70,
                expandedHeight: 200.0,
                backgroundColor: innerBoxIsScrolled? Theme.of(context).cardColor: Theme.of(context).primaryColor,
                floating: false,
                pinned: true,
                automaticallyImplyLeading : innerBoxIsScrolled?  true : false,
                leading: innerBoxIsScrolled? InkWell(onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor,)) : const SizedBox(),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: innerBoxIsScrolled? Text(getTranslated('loyalty_point', context)!,
                      style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeLarge),): const SizedBox(),
                    background: const LoyaltyPointTopCard()),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                    height: 50,
                    child: Container(color: Theme.of(context).canvasColor,
                      child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
                        child: Text('${getTranslated('point_history', context)}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      ),
                    ),
                  )),
            ];
          },
          body: isGuestMode ? const NotLoggedInWidget() :
          SingleChildScrollView(child: LoyaltyPointListView(scrollController: scrollController)),
        )

      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Consumer<ProfileProvider>(
              builder: (context, profile, _){
                return CustomButton(
                  leftIcon : Images.dollarIcon,
                  buttonText: '${getTranslated('convert_to_currency', context)}',
                  onTap: () {
                    showDialog(context: context, builder: (context) =>  Dialog(
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      child: LoyaltyPointConverterDialogue(myPoint: profile.userInfoModel!.loyaltyPoint ?? 0),
                    ),);
                  },
                );
              }

          ),
        )


    );
  }
}
