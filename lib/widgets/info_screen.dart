import 'package:covid19chile/constant.dart';
import 'package:covid19chile/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[MyHeader(
        image: "assets/icons/coronadr.svg",
        textTop: "Conocer sobre",
        textBottom: "Covid-19",
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Sintomas",
                style: kTitleTextstyle
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SymptomCard(
                  image: "assets/images/caugh.png",
                  title: "Tos",
                  isActive: true,
                ),
                SymptomCard(
                  image: "assets/images/headache.png",
                  title: "Dolor de \n  cabeza",
                ),

                SymptomCard(
                  image: "assets/images/fever.png",
                  title: "Fiebre",
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Prevencion", style: kTitleTextstyle),
            SizedBox(height: 20),
            SizedBox(height: 156,
              child: Stack(
                alignment:  Alignment.centerLeft,
                children: <Widget>[Container(
                  height: 136,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      offset: Offset(0, 8),
                      blurRadius: 24,
                      color: kShadowColor,
                    ),
                    ],
                  ),
                ),
                  Image.asset("assets/images/wear_mask.png"),
                  Positioned(
                    left: 130,
                    child: Container(
                      height: 136,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Ponte mascarilla",
                            style: kTitleTextstyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text("data")
                        ],
                      ),
                  ),)
                ],
            ),
            )
          ],
        ),
      )
      ],
    ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;

  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 120,
      height: 155,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive ?
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: kActiveShadowColor,
        )
        : BoxShadow(
    offset: Offset(0,3),
    blurRadius: 6,
    color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
        ],
      ),
    );
  }
}
