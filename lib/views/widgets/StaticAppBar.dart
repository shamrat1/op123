import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/states/CreditState.dart';
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
      InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "You've ${context.read(creditProvider)} coins in the wallet currently.")));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.monetization_on_outlined,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Coins",
              style: getDefaultTextStyle(size: 12.sp),
            ),
          ],
        ),
      ),
    ],
  );
}
