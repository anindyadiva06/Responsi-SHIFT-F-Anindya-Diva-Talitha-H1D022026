class ApiUrl {
  static const String baseUrl = 'https://responsi.webwizards.my.id/api/keuangan';

  static const String registrasi = 'https://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'https://responsi.webwizards.my.id/api/login';
  static const String listTransaksi = baseUrl + '/kategori_transaksi';
  static const String createTransaksi = baseUrl + '/kategori_transaksi';

  static String updateTransaksi(int id) {
    return baseUrl + '/kategori_transaksi/' + id.toString() + '/update'; 
  }

  static String showTransaksi(int id) {
    return baseUrl + '/kategori_transaksi/' + id.toString();
  }

  static String deleteTransaksi(int id) {
    return baseUrl + '/kategori_transaksi/' + id.toString() + '/delete';
  }
}