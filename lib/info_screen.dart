import 'package:covid19chile/constant.dart';
import 'package:covid19chile/widgets/my_header_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[MyHeader2(
          image: "assets/icons/coronadr2.svg",
          textTop: "Conocer sobre",
          textBottom: "Covid-19",
          offset: offset,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Síntomas",
                  style: kTitleTextstyle
              ),
              SizedBox(height: 15),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 5, top: 5),
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SymptomCard(
                    image: "assets/images/caugh.png",
                    title: "Tos",
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
          ),
              SizedBox(height: 15),
              Text("Prevención", style: kTitleTextstyle),
              SizedBox(height: 15),
              PreventCard(
                text: "Antes de salir a cualquier parte, recuerda ponerte una mascarilla para evitar contagios.",
                image: "assets/images/wear_mask2.png",
                title: "Ponte mascarilla",
              ),
              PreventCard(
                text: "Recuerda en todo momento lavar tus manos con jabón o gel antibacterial, ya sea antes salir o al llegar a tu hogar.",
                image: "assets/images/wash_hands2.png",
                title: "Lava tus manos",
              ),
              SizedBox(height: 20),
            ],
          ),
        )
        ],
    ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;

  const PreventCard({
    Key key, this.image, this.title, this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 130,
        child: Stack(
          alignment:  Alignment.centerLeft,
          children: <Widget>[Container(
            height: 136,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                offset: Offset(0, 8),
                blurRadius: 24,
                color: kShadowColor,
              ),
              ],
            ),
          ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
            ),)
          ],
      ),
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
        margin: EdgeInsets.only(left: 7, right: 7),
      width: 110,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 10,
                  color: kActiveShadowColor,
              )
              : BoxShadow(
                  offset: Offset(0,10),
                  blurRadius: 100,
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
