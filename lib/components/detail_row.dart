
import 'package:fertilizerapp/components/Gtext.dart';
import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String detail;
  final String fdetail;

  const DetailRow({super.key, required this.detail, required this.fdetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      height: 30,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(width: 140, child: Gtextfd(text: detail)),
          Gtextfd(text: " : "),
          Gtextnm(text: fdetail)
        ],
      ),
    );
  }
}
