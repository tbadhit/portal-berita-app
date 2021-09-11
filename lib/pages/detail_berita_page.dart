import 'package:flutter/material.dart';
import 'package:portal_berita_app/model/berita_item.dart';

class DetailBeritaPage extends StatefulWidget {
  final Article article;

  const DetailBeritaPage({Key? key, required this.article}) : super(key: key);

  @override
  _DetailBeritaPageState createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.network(widget.article.urlToImage),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${widget.article.content}"),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("${widget.article.publishedAt}"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
