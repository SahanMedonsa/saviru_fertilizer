
import 'package:fertilizerapp/components/Colorpallet.dart';
import 'package:flutter/material.dart';

class Gtext extends StatelessWidget {
  final String text;
  final double tsize;
  final Color tcolor;
  final FontWeight fweight;
  final TextAlign? textAlign;
  const Gtext(
      {super.key,
      required this.text,
      required this.tsize,
      required this.tcolor,
      required this.fweight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: tsize,
        color: tcolor,
        fontWeight: fweight,
      ),
      textAlign: textAlign,
    );
  }
}

class Gtextfd extends StatelessWidget {
  final String text;

  const Gtextfd({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: ColorPalette.appBar_color,
            fontSize: 16,
            fontWeight: FontWeight.w400));
  }
}

class Gtextnm extends StatelessWidget {
  final String text;

  const Gtextnm({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal));
  }
}
