// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelapp/style.dart';

Color _mainColor = Colors.black;
Color _backgroundColor = Colors.white;
Color _mainbodyColor = HexColor.fromHex("#F4EDF2");
Color _cardColor = Colors.white;

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Reservation",
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: _backgroundColor,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: Responsive.height(4, context),
                        color: _mainColor,
                      ),
                    ),
                    Container(
                      width: Responsive.width(75, context),
                      padding: EdgeInsets.all(Responsive.width(2, context)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Tìm kiếm'),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: Responsive.height(4, context),
                      color: _mainColor,
                    ),
                  ])),
          body: _searchResul(context),
        ));
  }

  Widget _searchResul(BuildContext context) {
    return Container();
  }
}
