import 'package:flutter/material.dart';
import 'package:portal_berita_app/model/berita_item.dart';
import 'package:portal_berita_app/service/service.dart';

import 'detail_berita_page.dart';

// Membuat request network
// Mengubah responsenya ke objek dart
// Ambil datanya
class PortalBeritaPage extends StatefulWidget {
  final String? title;

  const PortalBeritaPage({Key? key, this.title}) : super(key: key);

  @override
  _PortalBeritaPageState createState() => _PortalBeritaPageState();
}

class _PortalBeritaPageState extends State<PortalBeritaPage> {
  final service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          backgroundColor: Colors.black87,
        ),
        body: FutureBuilder(
          future: service.getData(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data as List<Article>)
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
                          article: article[position],
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
                            child: Container(
                              width: 100,
                              child: Text(
                                article[position].author,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
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
