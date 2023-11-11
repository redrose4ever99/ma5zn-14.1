import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/localization_provider.dart';
import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/app_constants.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/utill/size.dart';
import 'package:com.makzan.eco/view/screen/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreen();
}

class _ChooseLanguageScreen extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    Color prmColor = Theme.of(context).primaryColor;
    //var screenSize = MediaQuery.of(context).size;
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 200),
                  Center(
                    child: Image.asset(
                      "assets/images/Face.png",
                      fit: BoxFit.fill,
                      width: width(62),
                      height: height(62),
                      color: prmColor,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      getTranslated('choose_language_for', context)!,
                      style: onBoardtitle.copyWith(
                          fontSize: 20, color: Theme.of(context).hintColor),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      getTranslated('choose_language_for1', context)!,
                      style: onBoardtitle.copyWith(fontSize: 26),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Provider.of<LocalizationProvider>(context,
                                    listen: false)
                                .setLanguage(Locale(
                              AppConstants.languages[0].languageCode!,
                              AppConstants.languages[0].countryCode,
                            ));
                          },
                          child: Container(
                            width: fullWidth / 3,
                            height: fullWidth / 3,
                            decoration: BoxDecoration(
                                border: Border.all(color: prmColor),
                                color: Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false)
                                            .locale
                                            .languageCode ==
                                        AppConstants.languages[0].languageCode
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).highlightColor,
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            child: const Text("English"),
                          ),
                        ),
                        const SizedBox(width: 15),
                        TextButton(
                          onPressed: () {
                            Provider.of<LocalizationProvider>(context,
                                    listen: false)
                                .setLanguage(Locale(
                              AppConstants.languages[1].languageCode!,
                              AppConstants.languages[1].countryCode,
                            ));
                          },
                          child: Container(
                            width: fullWidth / 2.5,
                            height: fullWidth / 2.5,
                            decoration: BoxDecoration(
                                border: Border.all(color: prmColor),
                                color: Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false)
                                            .locale
                                            .languageCode ==
                                        AppConstants.languages[1].languageCode
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).highlightColor,
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            child: const Text(
                              "العربية",
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: width(200),
                    width: width(200),
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => OnBoardingScreen(
                                indicatorColor: ColorResources.grey,
                                selectedIndicatorColor:
                                    Theme.of(context).primaryColor)));
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Center(
                          child: Image.asset(
                            "assets/images/Next_button.png",
                            fit: BoxFit.fill,
                            width: width(100),
                            height: height(100),
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            )),
      ],
    ));
  }
}
