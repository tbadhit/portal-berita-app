import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portal_berita_app/detail_berita_page.dart';
import 'package:portal_berita_app/model/berita_item.dart';

// Membuat request network
// Mengubah responsenya ke objek dart
// Ambil datanya
class PortalBeritaPage extends StatefulWidget {
  final String title;

  const PortalBeritaPage({Key key, this.title}) : super(key: key);

  @override
  _PortalBeritaPageState createState() => _PortalBeritaPageState();
}

class _PortalBeritaPageState extends State<PortalBeritaPage> {
  Future<List<Article>> getData(String newsType) async {
    List<Article> list;
    String url =
        "https://newsapi.org/v2/top-headlines?country=id&apiKey=4e74bb32689b4f12b2e26cee1ca02dc0";
    // http headers bukan bagian dari URL
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    print(response.body);
    if (response.statusCode == 200) {
      // decode = Mengubah data json menjadi array
      var data = json.decode(response.body);
      var result = data['articles'] as List;
      print(result);
      list = result.map<Article>((json) => Article.fromJson(json)).toList();
    }

    print("List Size ${list.length}");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black87,
        ),
        body: FutureBuilder(
          future: getData(widget.title),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget listViewWidget(List<Article> article) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(2.0),
        itemCount: article.length,
        itemBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                var movePage = MaterialPageRoute(
                    builder: (contex) => DetailBeritaPage(
                          title: article[position].title,
                          urlToImage: article[position].urlToImage,
                          content: article[position].content,
                          publishedAt: article[position].publishedAt,
                        ));
                Navigator.push(context, movePage);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          article[position].urlToImage,
                          fit: BoxFit.fill,
                          width: 300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          article[position].title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, left: 15),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              article[position].author,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, right: 15),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              article[position].publishedAt,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[400]),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
