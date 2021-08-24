import 'package:flutter/material.dart';

class SliverPersistantHeaderDelegateImplementation
    extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  SliverPersistantHeaderDelegateImplementation(
      {required this.height, required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: Theme.of(context).backgroundColor,
      child: child,
      height: height,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
