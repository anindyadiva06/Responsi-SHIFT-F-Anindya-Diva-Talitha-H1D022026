import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/transaksi.dart';

class TransaksiBloc {
  static Future<List<Transaksi>> getTransaksis() async {
    String apiUrl = ApiUrl.listTransaksi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTransaksi = (jsonObj as Map<String, dynamic>)['data'];
    List<Transaksi> transaksis = [];
    for (int i = 0; i < listTransaksi.length; i++) {
      transaksis.add(Transaksi.fromJson(listTransaksi[i]));
    }
    return transaksis;
  }

  static Future addTransaksi({Transaksi? transaksi}) async {
    String apiUrl = ApiUrl.createTransaksi;

    var body = {
      "transaction": transaksi!.transaction2,
      "type": transaksi.type2,
      "amount": transaksi.amount2.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateTransaksi({required Transaksi transaksi}) async {
    String apiUrl = ApiUrl.updateTransaksi(transaksi.id!);
    print(apiUrl);

    var body = {
      "transaction": transaksi!.transaction2,
      "type": transaksi.type2,
      "amount": transaksi.amount2.toString()
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteTransaksi({int? id}) async {
    String apiUrl = ApiUrl.deleteTransaksi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
