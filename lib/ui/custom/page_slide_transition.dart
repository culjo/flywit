// Created By: Lekan Olad
// Machine : appy
// Date: 24/11/2018
// Time: 3:45 AM
import 'package:flutter/material.dart';

class PageSlideTransition extends PageRouteBuilder {
  final Widget widget;

  PageSlideTransition({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondary,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
                    begin: const Offset(1.0, .0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        });
}
