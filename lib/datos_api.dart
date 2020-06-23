import 'package:covid19chile/constant.dart';
import 'package:covid19chile/widgets/counter.dart';
import 'package:flutter/material.dart';


// Import para realizar API REST
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DatosApi1 extends StatelessWidget {
  const DatosApi1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Covid>(
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
    );
  }
}
class DatosApi2 extends StatelessWidget {
  const DatosApi2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Covid>(
      future: getCovid(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Extracción de Widget para simplicar codigo
                    Counter(
                      color: kInfectedColor,
                      number: "${snapshot.data.confirmed}",
                      title: "Contagiados",
                    ),
                    Counter(
                      color: kDeathColor,
                      number: "${snapshot.data.deaths}",
                      title: "Muertes",
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