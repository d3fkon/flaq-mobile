import 'package:flutter/material.dart';
import 'package:niku/macros/macros.dart';
import 'package:niku/namespace.dart' as n;

enum FButtonSize { small, medium, large }

abstract class FButtonSizeMacro {
  FButtonSize? size;
  void get small => size = FButtonSize.small;
  void get medium => size = FButtonSize.medium;
  void get large => size = FButtonSize.large;
}

class FButton extends StatelessWidget
    with NikuBuildMacro, UseQueryMacro<FButton>, FButtonSizeMacro {
  final Widget child;
  FButton(this.child, {Key? key}) : super(key: key);

  @override
  get widget => n.Niku(n.Niku(child)..center)
    ..py = size == FButtonSize.small ? 8 : 16
    ..px = size == FButtonSize.small ? 20 : 16
    ..useRoundedBorder(
      color: const Color(0xffEFEFEF),
      width: 1,
      rounded: 4,
    );
}
