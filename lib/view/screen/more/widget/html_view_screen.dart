import 'package:com.makzan.eco/provider/theme_provider.dart';
import 'package:com.makzan.eco/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:com.makzan.eco/utill/dimensions.dart';
import 'package:com.makzan.eco/view/basewidget/custom_app_bar.dart';
import 'package:provider/provider.dart';

class HtmlViewScreen extends StatelessWidget {
  final String? title;
  final String? url;
  const HtmlViewScreen({Key? key, required this.url, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              CustomAppBar(title: title),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  physics: const BouncingScrollPhysics(),
                  child: Html(
                    style: {
                      'html': Style(textAlign: TextAlign.justify)
                    },
                    data: url,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
