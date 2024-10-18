import 'dart:convert';
import 'package:health/helpers/api.dart';
import 'package:health/helpers/api_url.dart';
import 'package:health/model/pemantauan_tidur.dart';

class PemantauanTidurBloc {
  // Mengambil data sleep monitoring
  static Future<List<PemantauanTidur>> getData() async {
    String apiUrl = ApiUrl.listPemantauanTidur; // URL untuk API list pemantauan tidur
    var response = await Api().get(apiUrl);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List<dynamic> listPemantauan = (jsonObj as Map<String, dynamic>)['data'];
      return listPemantauan.map((data) => PemantauanTidur.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat data: ${response.reasonPhrase}');
    }
  }

  // Menambah data sleep monitoring
  static Future<bool> addData({required PemantauanTidur pemantauanTidur}) async {
    String apiUrl = ApiUrl.createPemantauanTidur; // URL untuk API create pemantauan tidur
    var body = {
      "sleep_quality": pemantauanTidur.sleepQuality,
      "sleep_hours": pemantauanTidur.sleepHours.toString(),
      "sleep_disorders": pemantauanTidur.sleepDisorders,
    };
    var response = await Api().post(apiUrl, body);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == true; // Kembalikan status boolean
    } else {
      throw Exception('Gagal menambah data: ${response.reasonPhrase}');
    }
  }

  // Mengupdate data sleep monitoring
  static Future<bool> updateData({required PemantauanTidur pemantauanTidur}) async {
    String apiUrl = ApiUrl.updatePemantauanTidur(pemantauanTidur.id!); // URL untuk update
    var body = {
      "sleep_quality": pemantauanTidur.sleepQuality,
      "sleep_hours": pemantauanTidur.sleepHours.toString(),
      "sleep_disorders": pemantauanTidur.sleepDisorders,
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == true; // Kembalikan status boolean
    } else {
      throw Exception('Gagal mengupdate data: ${response.reasonPhrase}');
    }
  }

  // Menghapus data sleep monitoring
  static Future<bool> deletePemantauanTidur({required int id}) async {
    String apiUrl = ApiUrl.deletePemantauanTidur(id); // URL untuk delete pemantauan tidur
    var response = await Api().delete(apiUrl);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == true; // Kembalikan status boolean
    } else {
      throw Exception('Gagal menghapus data: ${response.reasonPhrase}');
    }
  }

  // Tambahkan data pemantauan tidur
  static Future<bool> addPemantauanTidur({required PemantauanTidur pemantauanTidur}) async {
    return await addData(pemantauanTidur: pemantauanTidur);
  }

  // Update data pemantauan tidur
  static Future<bool> updatePemantauanTidur({required PemantauanTidur pemantauanTidur}) async {
    return await updateData(pemantauanTidur: pemantauanTidur);
  }
}
