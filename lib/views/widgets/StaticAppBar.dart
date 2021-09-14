import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:sizer/sizer.dart';

AppBar getStaticAppBar(BuildContext context, {String? title}) {
  return AppBar(
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
  );
}
