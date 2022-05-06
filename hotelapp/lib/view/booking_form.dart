// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelapp/data.dart';
import 'package:hotelapp/database/my_sql.dart';
import 'package:hotelapp/model/type_room.dart';
import 'package:hotelapp/style.dart';

Color _mainColor = Colors.black;
Color _backgroundColor = Colors.white;
Color _mainbodyColor = Colors.white;
Color _cardColor = HexColor.fromHex("#F4EDF2");

class Reservations extends StatefulWidget {
  const Reservations(this.typeRoom, {Key? key}) : super(key: key);

  final TypeRoom typeRoom;

  @override
  // ignore: no_logic_in_create_state
  State<Reservations> createState() => _ReservationsState(typeRoom);
}

class _ReservationsState extends State<Reservations> {
  final TypeRoom typeRoom;
  _ReservationsState(this.typeRoom);

  late int maso_yeucau;
  late int sophong_yeucau;
  late DateTime ngaydatphong;
  late String thoigian_nhanphong;
  late DateTime ngaynhan_phong;
  late String thoigian_traphong;
  late DateTime ngaytra_phong;
  late String ghichu;

  final int nhanvienpheduyet = 1;
  final String trangthai_yeucau = "Chưa Duyệt";

  bool checkDay() {
    bool f = false;
    int t1 = int.parse(thoigian_nhanphong
        .substring(0, thoigian_nhanphong.indexOf(":"))
        .trim());
    int t2 = int.parse(
        thoigian_traphong.substring(0, thoigian_traphong.indexOf(":")).trim());
    if (ngaynhan_phong.year >= ngaytra_phong.year) {
      if (ngaynhan_phong.year == ngaytra_phong.year) {
        if (ngaynhan_phong.month >= ngaytra_phong.month) {
          if (ngaynhan_phong.month == ngaytra_phong.month) {
            if (ngaynhan_phong.day >= ngaytra_phong.day) {
              if (ngaynhan_phong.day == ngaytra_phong.day) {
                if (t1 < t2) {
                  f = true;
                }
              }
            } else {
              f = true;
            }
          }
        } else {
          f = true;
        }
      }
    } else {
      f = true;
    }
    return f;
  }

  int _random(int k) {
    // Tạo ngẫu nhiên 1 số từ 1->k
    Random rd = Random();
    int result = rd.nextInt(k);
    return result;
  }

  Future _submit() async {
    if (checkDay()) {
      do {
        maso_yeucau = _random(9999);
      } while (maso_yeucau < 1000);
      ngaydatphong = DateTime.now();
      MySQL db = MySQL();
      var conn = await db.connectDB();
      String sql = "Insert into tbl_yeucaudatphong "
          "values('$maso_yeucau','${khachhang!.ma_kh.toString()}','${typeRoom.ma_lp}',"
          "'$sophong_yeucau','$ngaydatphong','${thoigian_nhanphong.substring(0, thoigian_nhanphong.indexOf(":")).trim()}'"
          ",'${"${ngaynhan_phong.toLocal()}".split(' ')[0]}','${thoigian_traphong.substring(0, thoigian_traphong.indexOf(":")).trim()}','${"${ngaytra_phong.toLocal()}".split(' ')[0]}',"
          "'$ghichu','$nhanvienpheduyet','$trangthai_yeucau')";
      try {
        await conn.query(sql);
        _showSTBK(context, 1);
      } catch (e) {
        _showSTBK(context, 0);
      }
      db.closeDB(conn);
    }
  }

  @override
  void initState() {
    thoigian_nhanphong = "7:00";
    thoigian_traphong = "6:00";
    ngaynhan_phong = DateTime.now();
    ngaytra_phong = DateTime.now();
    sophong_yeucau = 0;
    ghichu = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Reservation",
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: _backgroundColor,
            title: Row(
              children: [
                SizedBox(
                  width: Responsive.width(45, context),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text(
                            "Thông tin",
                            style: GoogleFonts.mavenPro(
                                fontSize: Responsive.height(3, context),
                                fontWeight: FontWeight.bold,
                                color: _mainColor),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: Responsive.width(45, context),
                )
              ],
            ),
          ),
          body: _form(context),
        ));
  }

  Widget _form(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Container(
      color: _mainbodyColor,
      child: Padding(
        padding: EdgeInsets.all(Responsive.width(3, context)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Responsive.width(60, context),
                padding: EdgeInsets.only(
                    top: Responsive.height(2, context),
                    left: Responsive.width(2, context)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Đặt " + typeRoom.ten_lp.toString(),
                    style: GoogleFonts.mavenPro(
                        fontSize: Responsive.height(3, context),
                        color: _mainColor),
                  ),
                ),
              ),
              Container(
                width: Responsive.width(60, context),
                padding: EdgeInsets.only(
                    bottom: Responsive.height(2, context),
                    left: Responsive.width(2, context)),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Responsive.width(40, context),
                    child: Divider(
                      color: _mainColor,
                      height: Responsive.height(2, context),
                      thickness: 2,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(left: Responsive.width(2, context)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Responsive.height(20, context),
                        width: Responsive.width(90, context),
                        padding: EdgeInsets.all(Responsive.height(1, context)),
                        decoration: BoxDecoration(
                            color: _cardColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _mainColor, width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Responsive.width(2, context)),
                                  child: Icon(
                                    Icons.person,
                                    color: _mainColor,
                                    size: Responsive.height(4, context),
                                  ),
                                ),
                                Text(
                                  "Họ và tên: ",
                                  style: TextStyle(
                                      fontSize: Responsive.height(2, context),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(khachhang!.hoten_kh.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            Responsive.height(2, context))),
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
                                  padding: EdgeInsets.only(
                                      right: Responsive.width(2, context)),
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
                                    style: TextStyle(
                                        fontSize:
                                            Responsive.height(2, context))),
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
                                  padding: EdgeInsets.only(
                                      right: Responsive.width(2, context)),
                                  child: Icon(
                                    Icons.phone,
                                    color: _mainColor,
                                    size: Responsive.height(4, context),
                                  ),
                                ),
                                Text("SĐT: ",
                                    style: TextStyle(
                                        fontSize: Responsive.height(2, context),
                                        fontWeight: FontWeight.bold)),
                                Text(khachhang!.sodienthoai_kh.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            Responsive.height(2, context))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: Responsive.height(2, context),
                    top: Responsive.height(2, context),
                    left: Responsive.width(2, context),
                    right: Responsive.width(2, context)),
                child: TextFormField(
                  onChanged: (value) {
                    try {
                      sophong_yeucau = int.parse(value);
                    } catch (e) {
                      return;
                    }
                  },
                  controller: TextEditingController(
                    text: sophong_yeucau == 0 ? "" : sophong_yeucau.toString(),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập vào số phòng',
                    labelText: 'Số phòng',
                    labelStyle: TextStyle(
                        fontSize: Responsive.height(2, context),
                        fontFamily: "Arial"),
                  ),
                  validator: (value) {
                    try {
                      sophong_yeucau = int.parse(value!);
                    } catch (e) {
                      return 'Số phòng không hợp lệ';
                    }
                    if (value.isEmpty) {
                      return 'Vui lòng không để trống';
                    }
                    if (int.parse(value) < 0) {
                      return 'Số phòng không hợp lệ';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Responsive.height(2, context),
                    left: Responsive.width(2, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ngày nhận phòng",
                        style: TextStyle(
                            fontSize: Responsive.height(2, context),
                            fontFamily: "Arial",
                            fontWeight: FontWeight.normal)),
                    SizedBox(
                      height: Responsive.height(2, context),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: Responsive.width(2, context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: _backgroundColor,
                                border: Border.all(color: _mainColor, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: Responsive.height(5, context),
                            padding: EdgeInsets.only(
                              left: Responsive.width(2, context),
                            ),
                            child: DropdownButton<String>(
                              value: thoigian_nhanphong,
                              underline: Container(color: _mainbodyColor),
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: Responsive.height(4, context),
                              ),
                              style: TextStyle(color: _mainColor),
                              onChanged: (String? newValue) {
                                setState(() {
                                  thoigian_nhanphong = newValue!;
                                  checkDay();
                                });
                              },
                              items: <String>[
                                '7:00',
                                '12:00',
                                '18:00',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: Responsive.width(25, context),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize:
                                              Responsive.height(2, context)),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.width(5, context),
                          ),
                          Container(
                            height: Responsive.height(5, context),
                            width: Responsive.width(50, context),
                            decoration: BoxDecoration(
                                color: _backgroundColor,
                                border: Border.all(color: _mainColor, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(
                              left: Responsive.width(2, context),
                              right: Responsive.width(2, context),
                            ),
                            child: InkWell(
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: ngaynhan_phong,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2099),
                                );
                                if (picked != null &&
                                    picked != ngaynhan_phong) {
                                  setState(() {
                                    ngaynhan_phong = picked;
                                    checkDay();
                                  });
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${ngaynhan_phong.day.toString()}-${ngaynhan_phong.month}-${ngaynhan_phong.year}",
                                    style: TextStyle(
                                        fontSize: Responsive.height(2, context),
                                        fontFamily: "Arial"),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(5, context),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    size: Responsive.height(2, context),
                                    color: _mainColor,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Responsive.height(2, context),
                    left: Responsive.width(2, context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ngày trả phòng",
                        style: TextStyle(
                            fontSize: Responsive.height(2, context),
                            fontFamily: "Arial",
                            fontWeight: FontWeight.normal)),
                    SizedBox(
                      height: Responsive.height(2, context),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: Responsive.width(2, context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: _backgroundColor,
                                border: Border.all(color: _mainColor, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            height: Responsive.height(5, context),
                            padding: EdgeInsets.only(
                              left: Responsive.width(2, context),
                            ),
                            child: DropdownButton<String>(
                              value: thoigian_traphong,
                              underline: Container(color: _mainbodyColor),
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: Responsive.height(4, context),
                              ),
                              style: TextStyle(color: _mainColor),
                              onChanged: (String? newValue) {
                                setState(() {
                                  thoigian_traphong = newValue!;
                                  checkDay();
                                });
                              },
                              items: <String>[
                                '6:00',
                                '11:00',
                                '17:00',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: Responsive.width(25, context),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize:
                                              Responsive.height(2, context)),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.width(5, context),
                          ),
                          Container(
                            height: Responsive.height(5, context),
                            width: Responsive.width(50, context),
                            decoration: BoxDecoration(
                                color: _backgroundColor,
                                border: Border.all(color: _mainColor, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(
                              left: Responsive.width(2, context),
                              right: Responsive.width(2, context),
                            ),
                            child: InkWell(
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: ngaytra_phong,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2099),
                                );
                                if (picked != null && picked != ngaytra_phong) {
                                  setState(() {
                                    ngaytra_phong = picked;
                                    checkDay();
                                  });
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${ngaytra_phong.day.toString()}-${ngaytra_phong.month}-${ngaytra_phong.year}",
                                    style: TextStyle(
                                        fontSize: Responsive.height(2, context),
                                        fontFamily: "Arial"),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(5, context),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    size: Responsive.height(2, context),
                                    color: _mainColor,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              checkDay()
                  ? SizedBox(
                      height: Responsive.height(4, context),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: Responsive.height(2, context),
                          left: Responsive.width(2, context)),
                      child: Text(
                        "Ngày nhận phòng và ngày trả phòng chưa hợp lệ",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: Responsive.height(2, context),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(
                    top: Responsive.height(3, context),
                    left: Responsive.width(2, context),
                    right: Responsive.width(2, context)),
                child: TextFormField(
                  controller: TextEditingController(text: ghichu),
                  onChanged: (value) {
                    ghichu = value;
                  },
                  decoration: InputDecoration(
                    hintText: '',
                    labelText: 'Ghi chú',
                    labelStyle: TextStyle(
                        fontSize: Responsive.height(2, context),
                        fontFamily: "Arial"),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: Responsive.height(2, context),
                      left: Responsive.width(2, context)),
                  child: RaisedButton(
                    color: Colors.amber,
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.height(1, context)),
                      child: Text(
                        'Đặt phòng',
                        style:
                            TextStyle(fontSize: Responsive.height(2, context)),
                      ),
                    ),
                    onPressed: () {
                      // It returns true if the form is valid, otherwise returns false
                      if (_formKey.currentState!.validate()) {
                        if (checkDay()) {
                          _showCfBK(context);
                        }
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _showCfBK(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Xác nhận',
              style: TextStyle(fontSize: Responsive.height(3, context)),
            ),
            content: SizedBox(
              // height: Responsive.height(15, context),
              width: Responsive.width(65, context),
              child: SingleChildScrollView(
                child: Text(
                  'Bạn muốn đặt phòng này?',
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
                  _submit();
                },
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.height(1, context)),
                  child: Text(
                    'Hủy',
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

  void _showSTBK(BuildContext context, int st) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Xác nhận",
              style: TextStyle(fontSize: Responsive.height(3, context)),
            ),
            content: SizedBox(
              // height: Responsive.height(15, context),
              width: Responsive.width(65, context),
              child: SingleChildScrollView(
                child: Text(
                  st == 1 ? 'Thành công' : "Thất bại",
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
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
