// ignore_for_file: deprecated_member_use, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotelapp/data.dart';
import 'package:hotelapp/model/loai_phong.dart';
import 'package:hotelapp/model/khach_hang.dart';
import 'package:hotelapp/model/yeucau_datphong.dart';
import 'package:hotelapp/style.dart';
import 'package:hotelapp/view/dangnhap.dart';
import 'package:hotelapp/view/thongtin_phong.dart';
import 'package:hotelapp/view/timkiem.dart';

Color _mainColor = Colors.black;
Color _backgroundColor = Colors.white;
Color _homebodyColor = HexColor.fromHex("#F4EDF2");
Color _buttonColor = const Color.fromARGB(255, 52, 245, 58);

class _CarouselWithDots extends StatefulWidget {
  const _CarouselWithDots({Key? key}) : super(key: key);

  @override
  State<_CarouselWithDots> createState() => _CarouselWithDotsState();
}

class _CarouselWithDotsState extends State<_CarouselWithDots> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  Widget _card(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = [];
    for (int i = 0; i < danhSachLoaiPhong.length; i += 2) {
      var cardFir = Container(
        width: Responsive.width(43, context),
        decoration: BoxDecoration(
            color: _backgroundColor,
            border: Border.all(color: _mainColor, width: 1)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RoomInfo(danhSachLoaiPhong[i])),
            );
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: Responsive.height(20, context),
                    child: Image(
                      image: AssetImage(pathImage +
                          danhSachLoaiPhong[i].hinhanh![0].toString()),
                      fit: BoxFit.fill,
                    )),
                Container(
                  padding: EdgeInsets.all(Responsive.height(1, context)),
                  child: Column(
                    children: [
                      Text(
                        danhSachLoaiPhong[i].ten_lp.toString(),
                        style: GoogleFonts.asap(
                            fontSize: Responsive.height(2.5, context),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        toMoney(danhSachLoaiPhong[i].gia_lp!.toDouble()) +
                            " VND / m???t ????m",
                        style: GoogleFonts.notoSans(
                            fontSize: Responsive.height(1.8, context)),
                      )
                    ],
                  ),
                )
              ]),
        ),
      );
      var cardSec = i + 1 < danhSachLoaiPhong.length
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
                        builder: (context) =>
                            RoomInfo(danhSachLoaiPhong[i + 1])),
                  );
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: Responsive.height(20, context),
                          child: Image(
                            image: AssetImage(pathImage +
                                danhSachLoaiPhong[i + 1]
                                    .hinhanh![0]
                                    .toString()),
                            fit: BoxFit.fill,
                          )),
                      Container(
                        padding: EdgeInsets.all(Responsive.height(1, context)),
                        child: Column(
                          children: [
                            Text(
                              danhSachLoaiPhong[i + 1].ten_lp.toString(),
                              style: GoogleFonts.asap(
                                  fontSize: Responsive.height(2.5, context),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              toMoney(danhSachLoaiPhong[i + 1]
                                      .gia_lp!
                                      .toDouble()) +
                                  " VND / m???t ????m",
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
      imageSliders.add(card);
    }
    return Column(
      children: <Widget>[
        Divider(
          color: _mainColor,
          height: Responsive.height(2, context),
          thickness: 2,
        ),
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            autoPlay: false,
            enableInfiniteScroll: false,
          ),
          carouselController: _controller,
        ),
        SizedBox(
          height: Responsive.height(2, context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () => _controller.previousPage(),
              child: Icon(
                Icons.arrow_circle_left_outlined,
                size: Responsive.height(7, context),
                color: _mainColor,
              ),
            ),
            SizedBox(
              width: Responsive.width(3, context),
            ),
            InkWell(
              onTap: () => _controller.nextPage(),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                size: Responsive.height(7, context),
                color: _mainColor,
              ),
            ),
          ],
        ),
        Divider(
          color: _mainColor,
          height: Responsive.height(2, context),
          thickness: 2,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _reload() async {
    danhSachLoaiPhong = await LoaiPhong.getTypeRoomList();
    listYeuCauDatPhong = await YeuCauDatPhong.findMaKhachHang(khachhang!.ma_kh);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hotel app",
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Responsive.height(12, context)),
            child: AppBar(
              backgroundColor: _backgroundColor,
              title: Row(
                children: [
                  SizedBox(
                    width: Responsive.width(70, context),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Kh??ch S???n Y???n Vy",
                          style: TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height(3, context),
                              color: _mainColor)),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.width(18, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _reload();
                              });
                            },
                            child: Material(
                              color: _homebodyColor,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Responsive.height(0.3, context)),
                                child: Icon(
                                  Icons.restart_alt,
                                  size: Responsive.height(3.5, context),
                                  color: _mainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Searching()),
                              );
                            },
                            child: Material(
                              color: _homebodyColor,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Responsive.height(0.3, context)),
                                child: Icon(
                                  Icons.search,
                                  size: Responsive.height(3.5, context),
                                  color: _mainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    color: _homebodyColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: Responsive.width(20, context),
                      child: Icon(
                        Icons.home,
                        color: _mainColor,
                        size: Responsive.height(4, context),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: Responsive.width(20, context),
                      child: Icon(
                        Icons.event_available,
                        color: _mainColor,
                        size: Responsive.height(4, context),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: Responsive.width(20, context),
                      child: Icon(
                        Icons.info_rounded,
                        color: _mainColor,
                        size: Responsive.height(4, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            _homeBody(context),
            _bookingList(context),
            _persionInfo(context)
          ]),
        ),
      ),
    );
  }

  // Home
  Widget _homeBody(BuildContext context) {
    List<Widget> listDisplay = [];
    var slider = SizedBox(
      height: Responsive.height(30, context),
      width: Responsive.width(100, context),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: _displayImageSliders(),
      ),
    );
    listDisplay.add(slider);
    _displayRooms(context, listDisplay);
    return Container(
        padding: EdgeInsets.only(top: Responsive.height(2, context)),
        color: _homebodyColor,
        child: ListView(
          children: listDisplay,
        ));
  }

  List<Widget> _displayImageSliders() {
    List<String> imgList = [
      pathImage + 'slide1.jpg',
      pathImage + 'slide2.jpg',
      pathImage + 'slide3.jpg'
    ];
    List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Image(
                  image: AssetImage(item),
                  fit: BoxFit.fill,
                ),
              ),
            ))
        .toList();
    return imageSliders;
  }

  void _displayRooms(BuildContext context, List<Widget> listDisplay) {
    var typeRoom = Container(
      margin: EdgeInsets.fromLTRB(
          Responsive.width(5, context), 10, Responsive.width(5, context), 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Danh s??ch lo???i ph??ng',
                style: GoogleFonts.mavenPro(
                    fontSize: Responsive.height(3.5, context),
                    fontWeight: FontWeight.bold,
                    color: _mainColor)),
            SizedBox(
              height: Responsive.height(45, context),
              child: const _CarouselWithDots(),
            ),
          ]),
    );
    listDisplay.add(typeRoom);
  }

  // Booking List
  Widget _bookingList(BuildContext context) {
    List<Widget> listdisplay = [];
    try {
      for (int i = 0; i < listYeuCauDatPhong!.length; i++) {
        LoaiPhong thongtinphong = LoaiPhong.timLoaiPhongTheoMa(
            listYeuCauDatPhong![i].loaiphong_yeucau!, danhSachLoaiPhong);
        var item = Container(
          margin: EdgeInsets.only(top: Responsive.height(2, context)),
          width: Responsive.width(80, context),
          height: Responsive.height(30, context),
          padding: EdgeInsets.all(Responsive.width(3, context)),
          decoration: BoxDecoration(
              border: Border.all(color: _mainColor, width: 1),
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: Responsive.height(26, context),
                width: Responsive.width(40, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: Responsive.height(16, context),
                        width: Responsive.width(40, context),
                        decoration: BoxDecoration(
                            border: Border.all(color: _mainColor, width: 1)),
                        child: Image(
                          image: AssetImage(
                              pathImage + thongtinphong.hinhanh![0].toString()),
                          fit: BoxFit.fill,
                        )),
                    Container(
                      height: Responsive.height(10, context),
                      width: Responsive.width(40, context),
                      padding:
                          EdgeInsets.only(top: Responsive.height(2, context)),
                      decoration: BoxDecoration(
                          border: Border.all(color: _mainColor, width: 1)),
                      child: Column(
                        children: [
                          Text(
                            thongtinphong.ten_lp.toString(),
                            style: GoogleFonts.asap(
                                fontSize: Responsive.height(2.3, context),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${toMoney(thongtinphong.gia_lp!.toDouble())} VND / m???t ????m",
                            style: GoogleFonts.notoSans(
                                fontSize: Responsive.height(1.7, context)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: Responsive.height(26, context),
                width: Responsive.width(40, context),
                padding: EdgeInsets.all(Responsive.height(1, context)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: Responsive.height(2, context)),
                        child: Text(
                          "S??? ph??ng: ${listYeuCauDatPhong![i].sophong_yeucau}",
                          style: GoogleFonts.notoSans(
                              fontSize: Responsive.height(2, context)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: Responsive.height(0.5, context)),
                        child: Text(
                          "Ng??y nh???n ph??ng:",
                          style: GoogleFonts.notoSans(
                              fontSize: Responsive.height(2, context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: Responsive.height(2, context)),
                        child: Text(
                          "${listYeuCauDatPhong![i].thoigian_nhanphong}:00 "
                          "${listYeuCauDatPhong![i].ngaynhan_phong!.day}/"
                          "${listYeuCauDatPhong![i].ngaynhan_phong!.month}/"
                          "${listYeuCauDatPhong![i].ngaynhan_phong!.year}",
                          style: GoogleFonts.notoSans(
                              fontSize: Responsive.height(2, context)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: Responsive.height(0.5, context)),
                        child: Text(
                          "Ng??y tr??? ph??ng:",
                          style: GoogleFonts.notoSans(
                              fontSize: Responsive.height(2, context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: Responsive.height(0.5, context)),
                        child: Text(
                          "${listYeuCauDatPhong![i].thoigian_traphong}:00 "
                          "${listYeuCauDatPhong![i].ngaytra_phong!.day}/"
                          "${listYeuCauDatPhong![i].ngaytra_phong!.month}/"
                          "${listYeuCauDatPhong![i].ngaytra_phong!.year}",
                          style: GoogleFonts.notoSans(
                              fontSize: Responsive.height(2, context)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: Responsive.height(0.9, context)),
                        height: Responsive.height(4, context),
                        width: Responsive.width(40, context),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            onPressed: () async {},
                            color: Colors.red[200],
                            child: Padding(
                              padding: EdgeInsets.all(
                                  Responsive.height(0.5, context)),
                              child: Text(
                                "H???y b???",
                                style: GoogleFonts.notoSans(
                                    fontSize: Responsive.height(1.8, context)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
              )
            ],
          ),
        );
        listdisplay.add(item);
      }
    } catch (e) {
      print(e);
    }
    return Container(
      color: _homebodyColor,
      padding: EdgeInsets.fromLTRB(
          Responsive.width(5, context), 10, Responsive.width(5, context), 10),
      child: ListView(children: listdisplay),
    );
  }

  // PersionInfo
  Widget _persionInfo(BuildContext context) {
    return Container(
      color: _homebodyColor,
      padding: EdgeInsets.all(Responsive.height(2, context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Responsive.width(80, context),
            margin: EdgeInsets.only(bottom: Responsive.height(2, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kh??ch h??ng",
                  style: TextStyle(fontSize: Responsive.height(3, context)),
                ),
                SizedBox(
                  width: Responsive.width(28, context),
                  child: Divider(
                    color: _mainColor,
                    height: Responsive.height(2, context),
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Responsive.height(20, context),
            width: Responsive.width(90, context),
            padding: EdgeInsets.all(Responsive.height(1, context)),
            decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _mainColor, width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: Responsive.width(2, context)),
                      child: Icon(
                        Icons.person,
                        color: _mainColor,
                        size: Responsive.height(4, context),
                      ),
                    ),
                    Text(
                      "H??? v?? t??n: ",
                      style: TextStyle(
                          fontSize: Responsive.height(2, context),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(khachhang!.hoten_kh.toString(),
                        style:
                            TextStyle(fontSize: Responsive.height(2, context))),
                  ],
                ),
                Divider(
                  color: _mainColor,
                  height: 1,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: Responsive.width(2, context)),
                      child: Icon(
                        Icons.contact_mail,
                        color: _mainColor,
                        size: Responsive.height(4, context),
                      ),
                    ),
                    Text("CCCD: ",
                        style: TextStyle(
                            fontSize: Responsive.height(2, context),
                            fontWeight: FontWeight.bold)),
                    Text(khachhang!.cancuoc_kh.toString(),
                        style:
                            TextStyle(fontSize: Responsive.height(2, context))),
                  ],
                ),
                Divider(
                  color: _mainColor,
                  height: 1,
                  thickness: 2,
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(right: Responsive.width(2, context)),
                      child: Icon(
                        Icons.phone,
                        color: _mainColor,
                        size: Responsive.height(4, context),
                      ),
                    ),
                    Text("S??T: ",
                        style: TextStyle(
                            fontSize: Responsive.height(2, context),
                            fontWeight: FontWeight.bold)),
                    Text(khachhang!.sodienthoai_kh.toString(),
                        style:
                            TextStyle(fontSize: Responsive.height(2, context))),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Responsive.height(2, context)),
            child: InkWell(
              onTap: () {
                _showCfLogout(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _buttonColor,
                    borderRadius: BorderRadius.circular(20)),
                width: Responsive.width(90, context),
                padding: EdgeInsets.only(
                    top: Responsive.height(1, context),
                    bottom: Responsive.height(1, context)),
                alignment: Alignment.center,
                child: Text(
                  "????ng xu???t",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.height(3, context)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showCfLogout(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'X??c nh???n',
              style: TextStyle(fontSize: Responsive.height(3, context)),
            ),
            content: SizedBox(
              // height: Responsive.height(15, context),
              width: Responsive.width(65, context),
              child: SingleChildScrollView(
                child: Text(
                  'B???n mu???n ????ng xu???t?',
                  style: TextStyle(fontSize: Responsive.height(2, context)),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.height(1, context)),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Responsive.height(3, context)),
                  ),
                ),
                onPressed: () {
                  KhachHang.deleting("User.txt");
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.height(1, context)),
                  child: Text(
                    'H???y',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Responsive.height(3, context)),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
