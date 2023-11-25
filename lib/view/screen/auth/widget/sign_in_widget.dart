import 'package:com.makzan.eco/utill/size.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:com.makzan.eco/data/model/body/login_model.dart';
import 'package:com.makzan.eco/helper/velidate_check.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/main.dart';
import 'package:com.makzan.eco/provider/auth_provider.dart';
import 'package:com.makzan.eco/provider/profile_provider.dart';
import 'package:com.makzan.eco/provider/splash_provider.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/basewidget/custom_button.dart';
import 'package:com.makzan.eco/view/basewidget/custom_textfield.dart';
import 'package:com.makzan.eco/view/basewidget/show_custom_snakbar.dart';
import 'package:com.makzan.eco/view/screen/auth/forget_password_screen.dart';
import 'package:com.makzan.eco/view/screen/auth/widget/mobile_verify_screen.dart';
import 'package:com.makzan.eco/view/screen/auth/widget/social_login_widget.dart';
import 'package:com.makzan.eco/view/screen/dashboard/dashboard_screen.dart';

import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import 'otp_verification_screen.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  SignInWidgetState createState() => SignInWidgetState();
}

class SignInWidgetState extends State<SignInWidget> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  bool _supportState = false;
  late final LocalAuthentication auth;
  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController!.text =
        (Provider.of<AuthProvider>(context, listen: false).getUserEmail());
    _passwordController!.text =
        (Provider.of<AuthProvider>(context, listen: false).getUserPassword());
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();
      String email = _emailController!.text.trim();
      String password = _passwordController!.text.trim();
      if (!Provider.of<AuthProvider>(context, listen: false).isGuestIdExist()) {
        Provider.of<AuthProvider>(context, listen: false).getGuestIdUrl();
      }
      if (Provider.of<AuthProvider>(context, listen: false).isRemember!) {
        Provider.of<AuthProvider>(context, listen: false)
            .saveUserEmail(email, password);
      } else {
        Provider.of<AuthProvider>(context, listen: false)
            .clearUserEmailAndPassword();
      }
      loginBody.email = email;
      loginBody.password = password;

      loginBody.guestId =
          Provider.of<AuthProvider>(context, listen: false).getGuestToken() ??
              '1';
      if (email.isEmpty) {
        showCustomSnackBar(
            getTranslated('user_name_is_required', context), context);
      } else if (password.isEmpty) {
        showCustomSnackBar(
            getTranslated('password_is_required', context), context);
      } else if (password.length < 8) {
        showCustomSnackBar(
            getTranslated('minimum_password_length', context), context);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(loginBody, route);
      }
    }
  }

  route(bool isRoute, String? token, String? temporaryToken,
      String? errorMessage) async {
    if (isRoute) {
      if (token == null || token.isEmpty) {
        if (Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .emailVerification!) {
          Provider.of<AuthProvider>(context, listen: false)
              .checkEmail(_emailController!.text.toString(), temporaryToken!)
              .then((value) async {
            if (value.isSuccess) {
              Provider.of<AuthProvider>(context, listen: false)
                  .updateEmail(_emailController!.text.toString());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VerificationScreen(temporaryToken, '',
                          _emailController!.text.toString())),
                  (route) => false);
            }
          });
        } else if (Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .phoneVerification!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => MobileVerificationScreen(temporaryToken!)),
              (route) => false);
        }
      } else {
        await Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (_) => const DashBoardScreen()),
            (route) => false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isRemember;

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Form(
        key: _formKeyLogin,
        child: Column(
          children: [
            Hero(
              tag: 'user',
              child: CustomTextField(
                  hintText: getTranslated('enter_email_or_mobile', context),
                  labelText: getTranslated('user_name', context),
                  focusNode: _emailNode,
                  nextFocus: _passNode,
                  isRequiredFill: true,
                  prefixIcon: Images.username,
                  inputType: TextInputType.emailAddress,
                  controller: _emailController,
                  showLabelText: true,
                  required: true,
                  validator: (value) => ValidateCheck.validateEmptyText(
                      value, "enter_email_or_mobile")),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            CustomTextField(
                showLabelText: true,
                required: true,
                labelText: getTranslated('password', context),
                hintText: getTranslated('enter_your_password', context),
                inputAction: TextInputAction.done,
                isPassword: true,
                prefixIcon: Images.pass,
                focusNode: _passNode,
                controller: _passwordController,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, 'ENTER_YOUR_PASSWORD')),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                      return InkWell(
                        onTap: () => authProvider.updateRemember(),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.75),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(
                              CupertinoIcons.checkmark_alt,
                              size: 15,
                              color: authProvider.isRemember!
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.75)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Text(getTranslated('remember', context)!,
                          style: textRegular),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgetPasswordScreen())),
                  child: Text('${getTranslated('forget_password', context)!}?',
                      style: titilliumRegular.copyWith(
                          color: ColorResources.getPrimary(context))),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: width(60), right: width(60)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, top: 30),
                child: Provider.of<AuthProvider>(context).isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : Hero(
                        tag: "onTap",
                        child: CustomButton(
                            onTap: loginUser,
                            buttonText: getTranslated('LOGIN', context))),
              ),
            ),
            if (_supportState)
              const SizedBox(width: Dimensions.paddingSizeDefault),
            if (_supportState)
              Center(
                child: Text(getTranslated('signiture_log_hint', context)!),
              ),
            if (_supportState)
              const SizedBox(height: Dimensions.paddingSizeEight),
            if (_supportState)
              Center(
                child: GestureDetector(
                  onTap: _authPrint,
                  child: Image.asset(Images.fingerprint,
                      width: width(49), height: height(54)),
                ),
              ),

            //segniture_log_hint
            const SizedBox(height: Dimensions.paddingSizeDefault),
            const SocialLoginWidget(),
            // Consumer<AuthProvider>(builder: (context, authProvider, _) {
            //   return GestureDetector(
            //     onTap: () {
            //       if (kDebugMode) {
            //         print("===Guest ID===${authProvider.getGuestToken()}====>");
            //       }
            //       if (!authProvider.isLoading) {
            //         Provider.of<AuthProvider>(context, listen: false)
            //             .getGuestIdUrl();
            //         Navigator.pushAndRemoveUntil(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (_) => const DashBoardScreen()),
            //             (route) => false);
            //       }
            //     },
            //     child: Container(
            //       width: double.infinity,
            //       height: 40,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         borderRadius: BorderRadius.circular(6),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(getTranslated('continue_as', context)!,
            //               style: titleRegular.copyWith(
            //                   color: ColorResources.getHint(context))),
            //           const SizedBox(
            //             width: Dimensions.paddingSizeExtraSmall,
            //           ),
            //           Text(getTranslated('guest', context)!,
            //               style: titleHeader),
            //         ],
            //       ),
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  Future<void> _authPrint() async {
    bool authenticated = await auth.authenticate(
        localizedReason: getTranslated('signiture_msg', context)!,
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true));
    if (authenticated) {
      Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (_) => const DashBoardScreen()),
          (route) => false);
    }

    // Future<void> _getAvailableBiometrics() async {
    //   List<BiometricType> availableBeometric =
    //       await auth.getAvailableBiometrics();

    // }
  }
}
