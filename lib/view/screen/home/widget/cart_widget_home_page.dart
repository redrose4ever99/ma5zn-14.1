import 'package:com.makzan.eco/utill/size.dart';
import 'package:com.makzan.eco/view/screen/home/widget/location_widget_home_page.dart';
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/provider/cart_provider.dart';
import 'package:com.makzan.eco/utill/color_resources.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:com.makzan.eco/view/screen/cart/cart_screen.dart';
import 'package:provider/provider.dart';

class CartWidgetHomePage extends StatelessWidget {
  const CartWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LocationWidgetHomePage(),
        Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 12),
          child: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(Images.cartArrowDownImage,
                  height: 22,
                  width: 31,
                  color: ColorResources.getPrimary(context).withOpacity(.9)),
              Positioned(
                top: -4,
                right: -4,
                child: Consumer<CartProvider>(builder: (context, cart, child) {
                  return CircleAvatar(
                    radius: 7,
                    backgroundColor: ColorResources.red,
                    child: Text(cart.cartList.length.toString(),
                        style: titilliumSemiBold.copyWith(
                          color: ColorResources.white,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        )),
                  );
                }),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
