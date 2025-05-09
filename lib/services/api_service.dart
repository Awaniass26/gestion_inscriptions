import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class ApiService {
static const String baseUrl = 'http://localhost:3000/inscription';

  static Future<List<Student>> fetchStudents({String? classe}) async {
    final uri = Uri.parse(classe != null
        ? '$baseUrl?classe=${Uri.encodeComponent(classe)}'
        : baseUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception('Échec du chargement des étudiants');
    }
  }
}
