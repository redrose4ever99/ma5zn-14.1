import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/onboarding_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({
    Key? key,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  }) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Provider.of<OnBoardingProvider>(context, listen: false)
        .initBoardingList(context);

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Provider.of<ThemeProvider>(context).darkTheme
              ? const SizedBox()
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(Images.background, fit: BoxFit.fill),
                ),
          Consumer<OnBoardingProvider>(
            builder: (context, onBoardingList, child) => ListView(
              children: [
                SizedBox(
                  height: height * 0.86,
                  child: PageView.builder(
                    itemCount: onBoardingList.onBoardingList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Opacity(
                                opacity: 0.47,
                                child: ClipPath(
                                  clipper: WaveCliper(),
                                  child: Container(
                                    color: const Color(0xff03A197),
                                    height: screenSize.height * 0.65,
                                  ),
                                ),
                              ),
                              ClipPath(
                                  clipper: WaveCliper(),
                                  child: SizedBox(
                                    height: screenSize.height * 0.65 - 15,
                                    child: Image.asset(
                                      onBoardingList
                                          .onBoardingList[index].imageUrl,
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
                                    height: screenSize.height * 0.65 - 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _pageIndicators(
                                onBoardingList.onBoardingList, context),
                          ),
                          const SizedBox(height: 10),
                          Text(onBoardingList.onBoardingList[index].title,
                              style: onBoardtitle, textAlign: TextAlign.center),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                  onBoardingList
                                      .onBoardingList[index].description,
                                  textAlign: TextAlign.center,
                                  style: onBoarddescrip.copyWith(
                                    fontSize: height / 58,
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                    onPageChanged: (index) {
                      onBoardingList.changeSelectIndex(index);
                    },
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor,
                            ])),
                        child: TextButton(
                          onPressed: () {
                            if (Provider.of<OnBoardingProvider>(context,
                                        listen: false)
                                    .selectedIndex ==
                                onBoardingList.onBoardingList.length - 1) {
                              Provider.of<SplashProvider>(context,
                                      listen: false)
                                  .disableIntro();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthScreen()));
                            } else {
                              _pageController.animateToPage(
                                  Provider.of<OnBoardingProvider>(context,
                                              listen: false)
                                          .selectedIndex +
                                      1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                                onBoardingList.selectedIndex ==
                                        onBoardingList.onBoardingList.length - 1
                                    ? getTranslated('GET_STARTED', context)!
                                    : getTranslated('NEXT', context)!,
                                style: titilliumSemiBold.copyWith(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSizeLarge)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex
              ? 18
              : 7,
          height: 7,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex
                ? Theme.of(context).primaryColor
                : Colors.white,
            borderRadius:
                i == Provider.of<OnBoardingProvider>(context).selectedIndex
                    ? BorderRadius.circular(50)
                    : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }
}

class WaveCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);

    path.quadraticBezierTo(size.width * 0.15 + 30, size.height * 0.92,
        size.width * 0.3 + 40, size.height * 0.97);
    path.quadraticBezierTo(size.width * 0.75 + 40, size.height * 1.1,
        size.width, size.height * 0.5);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
