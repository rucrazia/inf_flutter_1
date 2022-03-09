import 'dart:convert';
import 'package:inf_project1/model/photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '26040819-7379007945550f08ef52c0aa6';
  //Http 통신
  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));


    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    // map인 형태의 데이터를 fromJson에 던져서 객체 형태로 만들어 준다.
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
