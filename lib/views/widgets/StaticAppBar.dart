import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar getStaticAppBar(BuildContext context, {String? title}) {
  return AppBar(
    iconTheme: IconThemeData(color: Theme.of(context).accentColor),
    centerTitle: true,
    backgroundColor: Theme.of(context).backgroundColor,
    title: title != null
        ? Text(
            title,
            style: getDefaultTextStyle(size: 18.sp, weight: FontWeight.w800),
          )
        : Container(
            height: 40,
            width: 200,
            child: SvgPicture.asset("assets/images/logo-light.svg"),
          ),
    actions: [
      Consumer(builder: (context, watch, child) {
        return Row(
          children: [
            Icon(Icons.monetization_on_outlined,
                color: Theme.of(context).accentColor),
            Text(
              "${watch(creditProvider).toString()} $currencylogoText",
              style: getDefaultTextStyle(size: 12.sp),
            ),
          ],
        );
      }),
    ],
  );
}
