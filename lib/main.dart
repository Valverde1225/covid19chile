import 'package:covid19chile/constant.dart';
//import 'package:covid19chile/widgets/counter.dart';
//import 'package:covid19chile/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


// Import para realizar API REST
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

class HomeScreen extends StatelessWidget{

  final Future<Covid> covid;
  HomeScreen({Key key, this.covid}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 40, top: 50, right: 20),
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ]
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/coronadr.svg",
                              width: 230,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                            Positioned(
                                top: 27,
                                left: 200,
                                child: Text(
                                  "Quedate \nen casa",
                                  style: kHeadingTextStyle.copyWith(
                                    color: Colors.white,
                              ),
                            ),
                            ),
                            Container(),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
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
                    }).toList(), onChanged: (value){},
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
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
















