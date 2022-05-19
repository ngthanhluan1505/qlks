// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hotelapp/data.dart';
import 'package:hotelapp/model/loai_phong.dart';
import 'package:hotelapp/model/khach_hang.dart';
import 'package:hotelapp/style.dart';
import 'package:hotelapp/view/trangchu.dart';
import 'package:hotelapp/model/yeucau_datphong.dart';
import 'package:mysql1/mysql1.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:math';

Color _mainColor = Colors.black;
Color _backgroundColor = const Color.fromARGB(255, 255, 255, 255);
Color _mainbodyColor = HexColor.fromHex("#F4EDF2");
Color _buttonColor = const Color.fromARGB(255, 32, 204, 38);

String _accountSid = 'AC481e332a878eb0a67e8845891ae21fde';
String _authToken = '670214766b125c2f43e5a86eb7aebd21';
String _twilioNumber = '+16109983965';

// TWILIO_FROM=+16109983965
// TWILIO_SID=AC481e332a878eb0a67e8845891ae21fde
// TWILIO_TOKEN=670214766b125c2f43e5a86eb7aebd21

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  late TwilioFlutter _twilioFlutter;
  late String _sdt;
  late String _mxn;
  late bool _inputEn;
  late bool _sendedMS;
  late bool _checkUS;
  late bool _checkSDT;

  @override
  void initState() {
    _twilioFlutter = TwilioFlutter(
        accountSid: _accountSid,
        authToken: _authToken,
        twilioNumber: _twilioNumber);
    _inputEn = true;
    _checkUS = false;
    _sendedMS = false;
    _checkSDT = true;
    _sdt = '';
    _mxn = '';
    super.initState();
  }

  int _random(int k) {
    // Tạo ngẫu nhiên 1 số từ 1->k
    Random rd = Random();
    int result = rd.nextInt(k);
    return result;
  }

  void _sendSms() async {
    int otp = 0;
    do {
      otp = _random(999999);
    } while (otp < 100000);
    //await _twilioFlutter.sendSMS(toNumber: _sdt, messageBody: _mess);
    khachhang?.setMa_xacnhan(Blob.fromString(otp.toString()));
    khachhang?.updateInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 149, 24, 198),
          child: Container(
            margin: EdgeInsets.only(
                top: Responsive.height(5, context),
                bottom: Responsive.height(5, context),
                left: Responsive.width(5, context),
                right: Responsive.width(5, context)),
            decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: Responsive.height(38, context),
                      height: Responsive.height(35, context),
                      child: const Image(
                        image: AssetImage('assets/images/lg-0.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Responsive.height(4, context)),
                  child: Text(
                    "Khách Hàng Đăng Nhập",
                    style: TextStyle(
                        fontSize: Responsive.height(3.5, context),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Responsive.height(3, context),
                      left: Responsive.width(10, context),
                      right: Responsive.width(10, context)),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Responsive.height(1, context),
                      bottom: Responsive.height(1, context),
                    ),
                    decoration: BoxDecoration(
                      color: _mainbodyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: Responsive.height(3, context),
                          color: _mainColor,
                        ),
                        SizedBox(
                          width: Responsive.width(2, context),
                        ),
                        SizedBox(
                          height: Responsive.height(5, context),
                          width: Responsive.width(55, context),
                          child: TextField(
                            controller: TextEditingController(text: _sdt),
                            onChanged: ((text) {
                              _sdt = text;
                            }),
                            readOnly: _checkUS,
                            obscureText: false,
                            style: TextStyle(
                                fontSize: Responsive.height(2.5, context),
                                color: _mainColor),
                            decoration: const InputDecoration(
                              hintText: "Số điện thoại",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _checkUS
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: Responsive.height(2, context),
                            left: Responsive.width(10, context),
                            right: Responsive.width(10, context)),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: Responsive.height(1, context),
                            bottom: Responsive.height(1, context),
                          ),
                          decoration: BoxDecoration(
                            color: _mainbodyColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                size: Responsive.height(3, context),
                                color: _mainColor,
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              SizedBox(
                                height: Responsive.height(5, context),
                                width: Responsive.width(55, context),
                                child: TextField(
                                  onChanged: ((text) {
                                    _mxn = text;
                                  }),
                                  obscureText: false,
                                  style: TextStyle(
                                      fontSize: Responsive.height(2.5, context),
                                      color: _mainColor),
                                  decoration: const InputDecoration(
                                    hintText: "Mã xác nhận",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(
                      top: Responsive.height(3, context),
                      bottom: Responsive.height(2, context)),
                  child: InkWell(
                    child: Container(
                      height: Responsive.height(7, context),
                      width: Responsive.width(70, context),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: _buttonColor),
                      child: Text(
                        !_checkUS ? "LẤY MÃ ĐĂNG NHẬP" : "ĐĂNG NHẬP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.height(3, context),
                            color: _backgroundColor),
                      ),
                    ),
                    onTap: (() async {
                      bool f = await _kiemtraKh(_sdt);
                      if (f) {
                        _checkUS = true;
                        if (_sendedMS) {
                          bool f2 = _mxn == khachhang!.ma_xacnhan.toString();
                          if (f2) {
                            _inputEn = true;
                            KhachHang.writing(
                                "1 ${khachhang?.sodienthoai_kh.toString()}");
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const _LoadingUI()),
                            );
                          } else {
                            setState(() {
                              _inputEn = false;
                            });
                          }
                        } else {
                          _sendSms();
                          setState(() {
                            _sendedMS = true;
                            _checkSDT = true;
                          });
                        }
                      } else {
                        setState(() {
                          _checkSDT = false;
                        });
                      }
                    }),
                  ),
                ),
                _checkUS
                    ? InkWell(
                        onTap: () {
                          _sendSms();
                          setState(() {
                            _inputEn = true;
                          });
                        },
                        child: Text(
                          "Gửi lại mã",
                          style: TextStyle(
                              fontSize: Responsive.height(2.5, context)),
                        ),
                      )
                    : Container(),
                _checkSDT
                    ? Container()
                    : Text(
                        "Số điện thoại không đúng",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: Responsive.height(2.5, context)),
                      ),
                _inputEn
                    ? Container()
                    : Padding(
                        padding:
                            EdgeInsets.only(top: Responsive.height(1, context)),
                        child: Text(
                          "Mã xác nhận không đúng",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Responsive.height(2.5, context)),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _kiemtraKh(String sdt) async {
    bool f = false;
    khachhang = await KhachHang.findUserBySDT(sdt);
    if (khachhang?.ma_kh != -1) {
      f = true;
    }
    return f;
  }
}

class _LoadingUI extends StatelessWidget {
  const _LoadingUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splashTransition: SplashTransition.slideTransition,
      //  pageTransitionType: PageTransitionType,
      splash: const Image(
        image: AssetImage('assets/images/loading.gif'),
        fit: BoxFit.fill,
      ),
      screenFunction: () async {
        danhSachLoaiPhong = await LoaiPhong.getTypeRoomList();
        listYeuCauDatPhong =
            await YeuCauDatPhong.findMaKhachHang(khachhang!.ma_kh);
        danhSachLoaiPhong = await LoaiPhong.getTypeRoomList();
        listYeuCauDatPhong =
            await YeuCauDatPhong.findMaKhachHang(khachhang!.ma_kh);
        return const HomePage();
      },
    );
  }
}
