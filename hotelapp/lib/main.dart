// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hotelapp/data.dart';
import 'package:hotelapp/model/khach_hang.dart';
import 'package:hotelapp/model/yeucau_datphong.dart';
import 'package:hotelapp/view/dangnhap.dart';
import 'package:hotelapp/view/trangchu.dart';

import 'model/loai_phong.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AnimatedSplashScreen.withScreenFunction(
            splash: const Image(
              image: AssetImage('assets/images/loading.gif'),
              fit: BoxFit.fill,
            ),
            screenFunction: () async {
              int log = 0;
              var st = await KhachHang.loading();
              if (st != "FileNull") {
                if (st.substring(0, 2).trim() == "1") {
                  log = 1;
                  khachhang =
                      await KhachHang.findUserBySDT(st.substring(2).trim());
                  danhSachLoaiPhong = await LoaiPhong.getTypeRoomList();
                  listYeuCauDatPhong =
                      await YeuCauDatPhong.findMaKhachHang(khachhang!.ma_kh);
                }
              }
              return log == 0 ? const LoginPage() : const HomePage();
            }),
      ),
    );
  }
}
