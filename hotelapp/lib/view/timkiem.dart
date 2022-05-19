// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelapp/data.dart';
import 'package:hotelapp/style.dart';
import 'package:hotelapp/view/thongtin_phong.dart';

import '../model/loai_phong.dart';

Color _mainColor = Colors.black;
Color _backgroundColor = Colors.white;

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  late List<LoaiPhong> _danhsachkq;

  @override
  void initState() {
    _danhsachkq = danhSachLoaiPhong;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Searching",
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
    List<Widget> listdisplay = [];
    for (int i = 0; i < _danhsachkq.length; i += 2) {
      var cardFir = Container(
        width: Responsive.width(43, context),
        decoration: BoxDecoration(
            color: _backgroundColor,
            border: Border.all(color: _mainColor, width: 1)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoomInfo(_danhsachkq[i])),
            );
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: Responsive.height(20, context),
                    child: Image(
                      image: AssetImage(
                          pathImage + _danhsachkq[i].hinhanh![0].toString()),
                      fit: BoxFit.fill,
                    )),
                Container(
                  padding: EdgeInsets.all(Responsive.height(1, context)),
                  child: Column(
                    children: [
                      Text(
                        _danhsachkq[i].ten_lp.toString(),
                        style: GoogleFonts.asap(
                            fontSize: Responsive.height(2.5, context),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        toMoney(_danhsachkq[i].gia_lp!.toDouble()) +
                            " VND / một đêm",
                        style: GoogleFonts.notoSans(
                            fontSize: Responsive.height(1.8, context)),
                      )
                    ],
                  ),
                )
              ]),
        ),
      );
      var cardSec = i + 1 < _danhsachkq.length
          ? Container(
              width: Responsive.width(43, context),
              decoration: BoxDecoration(
                  color: _backgroundColor,
                  border: Border.all(color: _mainColor, width: 1)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoomInfo(_danhsachkq[i + 1])),
                  );
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: Responsive.height(20, context),
                          child: Image(
                            image: AssetImage(pathImage +
                                _danhsachkq[i + 1].hinhanh![0].toString()),
                            fit: BoxFit.fill,
                          )),
                      Container(
                        padding: EdgeInsets.all(Responsive.height(1, context)),
                        child: Column(
                          children: [
                            Text(
                              _danhsachkq[i + 1].ten_lp.toString(),
                              style: GoogleFonts.asap(
                                  fontSize: Responsive.height(2.5, context),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              toMoney(_danhsachkq[i + 1].gia_lp!.toDouble()) +
                                  " VND / một đêm",
                              style: GoogleFonts.notoSans(
                                  fontSize: Responsive.height(1.8, context)),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            )
          : Container();
      var card = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [cardFir, cardSec],
      );
      listdisplay.add(card);
      listdisplay.add(SizedBox(
        height: Responsive.height(2, context),
      ));
    }
    return Container(
      color: _backgroundColor,
      margin: EdgeInsets.only(
          top: Responsive.height(2, context),
          bottom: Responsive.height(2, context),
          left: Responsive.width(5, context),
          right: Responsive.width(5, context)),
      child: ListView(children: listdisplay),
    );
  }
}
