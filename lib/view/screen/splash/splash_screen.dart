import 'dart:async';
import 'package:com.makzan.eco/view/screen/choose_language/choose_language.dart';
import 'package:com.makzan.eco/view/screen/started/started_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/auth_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/no_internet_screen.dart';
import 'package:com.makzan.eco/view/screen/dashboard/dashboard_screen.dart';
import 'package:com.makzan.eco/view/screen/maintenance/maintenance_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected
                ? getTranslated('no_connection', context)!
                : getTranslated('connected', context)!,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context)
        .then((bool isSuccess) {
      if (isSuccess) {
        Provider.of<SplashProvider>(context, listen: false)
            .initSharedPrefData();
        Timer(const Duration(seconds: 1), () {
          if (Provider.of<SplashProvider>(context, listen: false)
              .configModel!
              .maintenanceMode!) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const MaintenanceScreen()));
          } else if (Provider.of<AuthProvider>(context, listen: false)
              .isLoggedIn()) {
            Provider.of<AuthProvider>(context, listen: false)
                .updateToken(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const DashBoardScreen()));
          } else if (Provider.of<SplashProvider>(context, listen: false)
              .showIntro()!) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    const ChooseLanguageScreen()));

            //  Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       builder: (BuildContext context) => OnBoardingScreen(
            //           indicatorColor: ColorResources.grey,
            //           selectedIndicatorColor: Theme.of(context).primaryColor)));
          } else {
            Provider.of<AuthProvider>(context, listen: false)
                .getGuestIdUrl()
                .then((value) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const StartScreen()));
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // key: _globalKey,
      body: Provider.of<SplashProvider>(context).hasConnection
          ? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    width: 100, child: Image.asset(Images.icon, width: 100.0)),
                Text(AppConstants.appName,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                        color: Colors.white)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Text(AppConstants.slogan,
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.white)))
              ]),
            )
          : const NoInternetOrDataScreen(
              isNoInternet: true, child: SplashScreen()),
    );
  }
}
