import 'package:covid19chile/constant.dart';
import 'package:covid19chile/widgets/info_screen.dart';
import 'package:covid19chile/widgets/my_header.dart';
//import 'package:covid19chile/widgets/counter.dart';
//import 'package:covid19chile/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// Import para realizar API REST
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

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
      home: InfoScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget{

  final Future<Covid> covid;
  HomeScreen({Key key, this.covid}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          MyHeader(image: "assets/icons/Drcorona.svg",
            textTop: "Quedate",
            textBottom: "en casa",
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
            child: FutureBuilder<Covid>(
              future: getCovid(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Casos Actualizados\n",
                                    style:kTitleTextstyle
                                ),
                                TextSpan(
                                    text: ("Fecha:  ${snapshot.data.day}"),
                                    style: TextStyle(
                                      color: kTextLightColor,
                                    )
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Text("Ver Detalles",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        ),

                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Extracción de Widget para simplicar codigo
                Counter(
                  color: kInfectedColor,
                  number: 1045,
                  title: "Contagiados",
                ),
                Counter(
                  color: kDeathColor,
                  number: 87,
                  title: "Muertes",
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text(
                  "Mapa del virus",
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
            height: 178,
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
        ],
      ),
    );
  }
}



// Consumiendo API COVID 19 CHILE
Future<Covid> getCovid() async {
  String url = 'https://chile-coronapi.herokuapp.com/api/v3/latest/nation';
  final response =
  await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return Covid.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Covid {
  final int confirmed;
  final int deaths;
  final String day;

  Covid({this.confirmed, this.deaths, this.day});

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
        confirmed: json['confirmed'],
        deaths: json['deaths'],
        day: json['day']);
  }
}

// Se adapto lo realizado para obtener la fecha de la API en conjunto con el diseño