import 'package:flutter/material.dart';
import 'package:untitled3/project2/pages/user pages/color.dart';

class Offerbox extends StatelessWidget {
  final String offerText;
  final String offerPercentage;
  const Offerbox(
      {super.key, required this.offerText, required this.offerPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            height: 150,
            decoration: BoxDecoration(
                color: AppColor.SecondPrimaryColor, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [ Text(
                offerText,textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10,),
             Container(
                height: 35,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  offerPercentage,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.SecondPrimaryColor,
                  ),
                ),
              ),
        ]),
          ),
       
        ],
      ),
    );
  }
}
