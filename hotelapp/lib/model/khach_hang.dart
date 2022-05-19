// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:hotelapp/database/my_sql.dart';
import 'package:mysql1/mysql1.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class KhachHang {
  final int _ma_kh;
  Blob? _hoten_kh;
  Blob? _cancuoc_kh;
  Blob? _sodienthoai_kh;
  Blob? _ma_xacnhan;

  int get ma_kh => _ma_kh;
  Blob? get hoten_kh => _hoten_kh;
  Blob? get cancuoc_kh => _cancuoc_kh;
  Blob? get sodienthoai_kh => _sodienthoai_kh;
  Blob? get ma_xacnhan => _ma_xacnhan;

  void setMa_xacnhan(Blob otp) {
    _ma_xacnhan = otp;
  }

  KhachHang(this._ma_kh,
      [this._hoten_kh,
      this._cancuoc_kh,
      this._sodienthoai_kh,
      this._ma_xacnhan]);

  static Future<String> loading() async {
    Storage storage = Storage();
    var data = '';
    await storage.readData('User.txt').then((String value) {
      data = value;
    });
    return data;
  }

  static void writing(String data) {
    Storage storage = Storage();
    storage.writeData(data, 'User.txt');
  }

  static void deleting(String filename) {
    Storage storage = Storage();
    storage.delete(filename);
  }

  static Future<KhachHang> findUserBySDT(String sdt) async {
    KhachHang us = KhachHang(-1);
    MySQL db = MySQL();
    var conn = await db.connectDB();
    String sql =
        "SELECT * FROM `tbl_khachhang` WHERE sodienthoai_kh='" + sdt + "'";
    try {
      await conn.query(sql).then((rs) async {
        for (var row in rs) {
          us = KhachHang(row[0], row[1], row[2], row[3], row[4]);
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    db.closeDB(conn);
    return us;
  }

  Future updateInfo() async {
    MySQL db = MySQL();
    var conn = await db.connectDB();
    String sql =
        "UPDATE `tbl_khachhang` SET `hoten_kh`='${_hoten_kh.toString()}',"
        "`cancuoc_kh`='${_cancuoc_kh.toString()}',"
        "`sodienthoai_kh`='${_sodienthoai_kh.toString()}',"
        "`ma_xacnhan`='${_ma_xacnhan.toString()}'"
        " WHERE `ma_kh`='${_ma_kh.toString()}'";
    await conn.query(sql);
    db.closeDB(conn);
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> localFile(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  Future<String> readData(String fileName) async {
    try {
      final file = await localFile(fileName);
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return 'FileNull';
    }
  }

  Future<File> writeData(String data, String fileName) async {
    final file = await localFile(fileName);
    return file.writeAsString(data);
  }

  Future delete(String fileName) async {
    final file = await localFile(fileName);
    file.delete();
  }
}
