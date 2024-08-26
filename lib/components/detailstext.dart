
import 'package:fertilizerapp/components/Gtext.dart';
import 'package:flutter/material.dart';

class detailtext extends StatelessWidget {
  final String detail;
  final String db_datil;
  const detailtext({super.key, required this.detail, required this.db_datil});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //details
              Container(
                width: width * 0.4,
                child: Gtext(
                    text: ("$detail"),
                    tsize: 20,
                    tcolor: Colors.black,
                    fweight: FontWeight.w700),
              ),

              //

              Gtext(
                  text: (" :   "),
                  tsize: 18,
                  tcolor: Colors.black,
                  fweight: FontWeight.w500),

              //farmere details
              Gtext(
                  text: db_datil,
                  tsize: 18,
                  tcolor: Colors.black,
                  fweight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }
}
