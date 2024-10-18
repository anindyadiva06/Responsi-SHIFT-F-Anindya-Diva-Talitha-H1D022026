class Transaksi {
  int? id;
  String? transaction2;
  String? type2;
  int? amount2;
  Transaksi({this.id, this.transaction2, this.type2, this.amount2});
  factory Transaksi.fromJson(Map<String, dynamic> obj) {
    return Transaksi(
        id: obj['id'],
        transaction2: obj['transaction'],
        type2: obj['type'],
        amount2: obj['amount']);
  }
}
