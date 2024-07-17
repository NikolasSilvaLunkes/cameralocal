import 'package:app/infra/model/imagem.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImagemFeign {
  Future<List<Imagem>> fetchImageData() async {
    final response = await fetchFromApi();
    List<dynamic> data = jsonDecode(response);
    return data.map((json) => Imagem.fromJson(json)).toList();
  }

  Future<String> fetchFromApi() async {
    final response =
        await http.get(Uri.parse('http://m2.guilhermesperb.com.br/feed'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
