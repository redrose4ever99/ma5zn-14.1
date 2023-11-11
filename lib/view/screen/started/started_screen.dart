import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/utill/size.dart';
import 'package:com.makzan.eco/view/screen/auth/auth_screen.dart';
import 'package:com.makzan.eco/view/screen/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color prmColor = Theme.of(context).primaryColor;
    //var screenSize = MediaQuery.of(context).size;
    double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Provider.of<ThemeProvider>(context).darkTheme
            ? const SizedBox()
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(Images.background, fit: BoxFit.fill),
              ),
        SizedBox(
            height: fullHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.47,
                      child: ClipPath(
                        clipper: WaveCliper(),
                        child: Container(
                          color: const Color(0xff03A197),
                          height: fullHeight * 0.6,
                        ),
                      ),
                    ),
                    ClipPath(
                        clipper: WaveCliper(),
                        child: SizedBox(
                          height: fullHeight * 0.6 - 15,
                          child: Image.asset(
                            "assets/images/onboard4.png",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          ),
                          //  ImageConstant.imgImage,
                          //fit: BoxFit.cover,
                        )),
                    Opacity(
                      opacity: 0.21,
                      child: ClipPath(
                        clipper: WaveCliper(),
                        child: Container(
                          color: const Color(0xff028A81),
                          height: fullHeight * 0.6 - 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  getTranslated('Welcome_to_mz5an', context)!,
                  style: onBoardtitle,
                ),
                const SizedBox(height: 5),
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fill,
                    width: width(116),
                    height: height(62),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), color: prmColor),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(getTranslated('sign_in', context)!,
                          style: titilliumSemiBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), color: prmColor),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(getTranslated('sign_up', context)!,
                          style: titilliumSemiBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 70,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), color: prmColor),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(getTranslated('continu_as_gust', context)!,
                          style: titilliumSemiBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeLarge)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            )),
      ],
    ));
  }
}
