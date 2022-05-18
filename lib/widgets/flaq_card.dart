import 'package:flutter/material.dart';
import 'package:niku/macros/nikuBuild.dart';
import 'package:niku/macros/useQueryMacro.dart';
import 'package:niku/namespace.dart' as n;

class FCard extends StatelessWidget with NikuBuildMacro, UseQueryMacro<FCard> {
  final Widget child;
  FCard(this.child, {Key? key}) : super(key: key);

  @override
  get widget => n.Niku(n.Niku(child))
    ..wFull
    ..p = 24
    ..useBorder(
      color: const Color(0xff272727),
      width: 1,
    )
    ..backgroundColor = const Color(0xff131212);
}
