class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';

  // URL untuk Registrasi dan Login
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';

  // URL untuk Pemantauan Tidur
  static const String listPemantauanTidur =
      baseUrl + '/kesehatan' + '/pemantauan_tidur';
  static const String createPemantauanTidur = baseUrl + '/kesehatan' + '/pemantauan_tidur';

  static String updatePemantauanTidur(int id) {
    return baseUrl + '/kesehatan' + '/pemantauan_tidur/' + id.toString() + '/update';
  }

  static String deletePemantauanTidur(int id) {
    return baseUrl + '/kesehatan' + '/pemantauan_tidur/' + id.toString() + '/delete';
  }

  static String showPemantauanTidur(int id) {
    return baseUrl + '/kesehatan' + '/pemantauan_tidur/' + id.toString();
  }
}
