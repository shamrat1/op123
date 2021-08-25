import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar getStaticAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Theme.of(context).backgroundColor,
    title: Container(
      height: 40,
      width: 200,
      child: SvgPicture.asset("assets/images/logo-light.svg"),
    ),
  );
}
