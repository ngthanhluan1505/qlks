// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:hotelapp/database/my_sql.dart';
import 'package:mysql1/mysql1.dart';

class YeuCauDatPhong {
  final int _maso_yeucau;
  int? _khachhang_yeucau;
  int? _loaiphong_yeucau;
  int? _sophong_yeucau;
  DateTime? _ngaydat_phong;
  int? _thoigian_nhanphong;
  DateTime? _ngaynhan_phong;
  int? _thoigian_traphong;
  DateTime? _ngaytra_phong;
  Blob? _ghichu;
  int? _nhanvien_pheduyet;
  Blob? _trangthai_yeucau;

  int get maso_yeucau => _maso_yeucau;
  int? get khachhang_yeucau => _khachhang_yeucau;
  int? get loaiphong_yeucau => _loaiphong_yeucau;
  int? get sophong_yeucau => _sophong_yeucau;
  DateTime? get ngaydat_phong => _ngaydat_phong;
  int? get thoigian_nhanphong => _thoigian_nhanphong;
  DateTime? get ngaynhan_phong => _ngaynhan_phong;
  int? get thoigian_traphong => _thoigian_traphong;
  DateTime? get ngaytra_phong => _ngaytra_phong;
  Blob? get ghichu => _ghichu;
  int? get nhanvien_pheduyet => _nhanvien_pheduyet;
  Blob? get trangthai_yeucau => _trangthai_yeucau;

  YeuCauDatPhong(this._maso_yeucau,
      [this._khachhang_yeucau,
      this._loaiphong_yeucau,
      this._sophong_yeucau,
      this._ngaydat_phong,
      this._thoigian_nhanphong,
      this._ngaynhan_phong,
      this._thoigian_traphong,
      this._ngaytra_phong,
      this._ghichu,
      this._nhanvien_pheduyet,
      this._trangthai_yeucau]);

  static Future<List<YeuCauDatPhong>> findMaKhachHang(int makhachhang) async {
    List<YeuCauDatPhong> list = [];
    MySQL db = MySQL();
    var conn = await db.connectDB();
    String sql =
        "SELECT * FROM `tbl_yeucaudatphong` WHERE `khachhang_yeucau` = $makhachhang;";
    try {
      await conn.query(sql).then((rs) async {
        for (var row in rs) {
          list.add(YeuCauDatPhong(row[0], row[1], row[2], row[3], row[4],
              row[5], row[6], row[7], row[8], row[9], row[10], row[11]));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    db.closeDB(conn);

    return list;
  }

  // void test() {
  //   print(_maso_yeucau);
  //   print(_khachhang_yeucau);
  //   print(_loaiphong_yeucau);
  //   print(_sophong_yeucau);
  //   print(_ngaydat_phong);
  //   print(_thoigian_nhanphong);
  //   print(_ngaynhan_phong);
  //   print(_thoigian_traphong);
  //   print(_ngaytra_phong);
  //   print(_ghichu);
  //   print(_nhanvien_pheduyet);
  //   print(_trangthai_yeucau);
  // }
}
