// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:hotelapp/database/my_sql.dart';
import 'package:mysql1/mysql1.dart';

class LoaiPhong {
  final int _ma_lp;
  Blob? _ten_lp;
  int? _sogiuong;
  int? _kichthuoc;
  double? _gia_lp;
  Blob? _gioithieu;
  List<Blob>? _hinhanh;

  int get ma_lp => _ma_lp;
  Blob? get ten_lp => _ten_lp;
  int? get sogiong => _sogiuong;
  int? get kichthuoc => _kichthuoc;
  double? get gia_lp => _gia_lp;
  Blob? get gioithieu => _gioithieu;
  List<Blob>? get hinhanh => _hinhanh;

  LoaiPhong(this._ma_lp,
      [this._ten_lp,
      this._sogiuong,
      this._kichthuoc,
      this._gia_lp,
      this._gioithieu,
      this._hinhanh]);

  static Future<List<LoaiPhong>> getTypeRoomList() async {
    List<LoaiPhong> result = [];
    MySQL db = MySQL();
    var conn = await db.connectDB();
    String sql = 'SELECT * FROM `tbl_loaiphong`';
    try {
      await conn.query(sql).then((rs) async {
        for (var row in rs) {
          LoaiPhong typeRoom =
              LoaiPhong(row[0], row[1], row[2], row[3], row[4], row[5], []);
          String sql2 =
              'SELECT ha.ten_hinhanh FROM `tbl_loaiphong` lp JOIN `tbl_hinhanh` ha ON lp.ma_lp=ha.ma_lp WHERE lp.ma_lp=' +
                  typeRoom._ma_lp.toString();
          try {
            await conn.query(sql2).then((rs) {
              for (var img in rs) {
                typeRoom._hinhanh?.add(img[0]);
              }
            });
          } catch (e) {
            // ignore: avoid_print
            print(e);
          }
          result.add(typeRoom);
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    db.closeDB(conn);

    return result;
  }

  static LoaiPhong timLoaiPhongTheoMa(
      int ma_lp, List<LoaiPhong> danhsachloaiphong) {
    LoaiPhong rs = LoaiPhong(-1);
    for (int i = 0; i < danhsachloaiphong.length; i++) {
      if (ma_lp == danhsachloaiphong[i]._ma_lp) {
        rs = danhsachloaiphong[i];
        break;
      }
    }
    return rs;
  }
}
