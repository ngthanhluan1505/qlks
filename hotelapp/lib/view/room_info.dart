// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelapp/model/type_room.dart';
import 'package:hotelapp/style.dart';
import 'package:hotelapp/view/booking_form.dart';
import 'package:hotelapp/view/searching.dart';

Color _mainColor = Colors.black;
Color _backgroundColor = Colors.white;
Color _mainbodyColor = HexColor.fromHex("#F4EDF2");

class RoomInfo extends StatelessWidget {
  const RoomInfo(this.typeRoom, {Key? key}) : super(key: key);
  final TypeRoom typeRoom;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Room Info",
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: _backgroundColor,
            title: Row(
              children: [
                SizedBox(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: Responsive.height(4, context),
                              color: _mainColor,
                            )))),
                SizedBox(
                  width: Responsive.width(85, context),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: Responsive.width(1, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          typeRoom.ten_lp.toString(),
                          style: GoogleFonts.mavenPro(
                              fontSize: Responsive.height(3, context),
                              fontWeight: FontWeight.bold,
                              color: _mainColor),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Searching()),
                              );
                            },
                            child: Icon(
                              Icons.search,
                              size: Responsive.height(4, context),
                              color: _mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          body: _roomInfoBody(context)),
    );
  }

  Widget _roomInfoBody(BuildContext context) {
    List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    ];
    return Container(
      width: Responsive.width(100, context),
      padding: EdgeInsets.all(Responsive.height(1, context)),
      color: _mainbodyColor,
      child: Column(
        children: [
          SizedBox(
              width: Responsive.width(80, context),
              height: Responsive.height(30, context),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child:
                    Image.network(imgList[0], fit: BoxFit.cover, width: 1000.0),
              )),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          SizedBox(
              width: Responsive.width(80, context),
              height: Responsive.height(30, context),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child:
                    Image.network(imgList[0], fit: BoxFit.cover, width: 1000.0),
              )),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Padding(
            padding: EdgeInsets.all(Responsive.height(1, context)),
            child: Text(
              "${typeRoom.sogiong} Giường - ${typeRoom.kichthuoc}",
              style: TextStyle(
                  fontSize: Responsive.height(2.5, context),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Responsive.height(1, context)),
            child: Text(
              "Giá: ${typeRoom.gia_lp} VNĐ / một đêm",
              style: TextStyle(fontSize: Responsive.height(2, context)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: Responsive.width(3, context),
                right: Responsive.width(3, context),
                top: Responsive.height(1, context),
                bottom: Responsive.height(1, context)),
            child: Text(
              typeRoom.gioithieu.toString(),
              style: TextStyle(
                fontSize: Responsive.height(2, context),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          Padding(
            padding: EdgeInsets.all(Responsive.height(1, context)),
            child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Reservations(typeRoom)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(Responsive.height(1, context)),
                  child: Text(
                    "Đặt Phòng Ngay",
                    style: TextStyle(
                        fontSize: Responsive.height(3, context),
                        fontWeight: FontWeight.w400),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
