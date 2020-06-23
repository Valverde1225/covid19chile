import 'package:covid19chile/constant.dart';
import 'package:covid19chile/info_screen.dart';
import 'package:covid19chile/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
//import 'package:covid19chile/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// Import para realizar API REST
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'datos_api.dart';
import 'widgets/counter.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 Chile',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
        home: HomeScreen(),

    );
  }
}

class HomeScreen extends StatefulWidget {
  final Future<Covid> covid;
  HomeScreen({Key key, this.covid}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
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
          children: <Widget>[
          MyHeader(image: "assets/icons/Drcorona.svg",
            textTop: "Quédate en",
            textBottom: "casa",
            offset: offset,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 60, width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color(0xFFE5E5E5),
              ),
            ),
            child: Row(
              children: <Widget>[SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                Expanded(child: DropdownButton(
                  isExpanded: true,
                  underline: SizedBox(),
                  icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                  value: "Chile",
                  items: [
                    'Chile',
                    'Argentina'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value){},
                ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal:20),
            child: DatosApi1(),
          ),

          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,4),
                  blurRadius: 30,
                  color: kShadowColor,
                ),
              ],

            ),
            child: DatosApi2(),

          ),
          SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text(
                  "Evolución del virus",
                  style: kTitleTextstyle,
              ),
              Text("Más detalles",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
              ),
              ],
            ),
            ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
            height: 390,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 30,
                    color: kShadowColor,

                ),
              ],
          ),
            child: Container(
                child: WebView(
                  initialUrl: Uri.dataFromString('<html><body><div class="flourish-embed flourish-chart" data-src="visualisation/1563538" data-url="https://public.flourish.studio/visualisation/1563538/embed"><script src="https://public.flourish.studio/resources/embed.js"></script></div></body></html>', mimeType: 'text/html').toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                ),
            ),
          ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              height: 390,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 30,
                    color: kShadowColor,

                  ),
                ],
              ),
              child: Container(
                child: WebView(
                  initialUrl: Uri.dataFromString('<html><body>'
                      '</body></html>', mimeType: 'text/html').toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                ),
            ),
            ),
        ],
      ),
      ),
    );
  }
}

