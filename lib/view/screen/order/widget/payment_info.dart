
import 'package:flutter/material.dart';
import 'package:com.makzan.eco/localization/language_constrants.dart';
import 'package:com.makzan.eco/provider/order_provider.dart';
import 'package:com.makzan.eco/utill/custom_themes.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/screen/checkout/widget/shipping_details_widget.dart';

class PaymentInfo extends StatelessWidget {
  final OrderProvider? order;
  const PaymentInfo({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(getTranslated('PAYMENT_STATUS', context)!,
                        style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

                    Text((order!.orders!.paymentStatus != null && order!.orders!.paymentStatus!.isNotEmpty) ?
                    order!.orders!.paymentStatus! : 'Digital Payment',
                      style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                  ]),
            ),


            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated('PAYMENT_PLATFORM', context)!,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              Text(order!.orders!.paymentMethod!.replaceAll('_', ' ').capitalize(), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ]),
          ]),
    );
  }
}
