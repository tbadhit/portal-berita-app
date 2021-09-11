import 'package:portal_berita_app/model/berita_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  Future<List<Article>?> getData() async {
    List<Article>? list;
    String url =
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=4e74bb32689b4f12b2e26cee1ca02dc0";
    // http headers bukan bagian dari URL
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // decode = Mengubah data json menjadi array
      var data = json.decode(response.body);
      var result = data['articles'] as List;
      list = result.map<Article>((json) => Article.fromJson(json)).toList();
    }
    return list;
  }
}
