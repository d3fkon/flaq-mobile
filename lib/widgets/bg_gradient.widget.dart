import 'package:flutter/material.dart';
import 'package:niku/niku.dart';
import 'package:niku/namespace.dart' as n;

class BGGradient extends StatelessWidget {
  final Widget child;
  const BGGradient({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return n.Stack([
      Niku(
        n.Box()
          ..rounded = 100
          ..bgBlur = 300
          ..align = Alignment.center
          ..gradient = RadialGradient(
            colors: [
              const Color(0xffF22FB0),
              // Color(0xffFFC56F),
              const Color(0xff8247E5).withOpacity(1)
            ],
          )
          ..h = 100,
      )
        ..w100
        ..pt = 100
        ..pl = 150,
      Niku(
        n.Box()
          ..rounded = 100
          ..bgBlur = 500
          ..align = Alignment.center
          ..gradient = RadialGradient(
            colors: [
              const Color(0xffF22FB0).withOpacity((1)),
              // Color(0xffFFC56F).withOpacity(0.4),
              const Color(0xff8247E5).withOpacity(1)
            ],
          )
          ..h = 100
          ..w = 100,
      )..pt = 500,
      child
    ]);
  }
}
